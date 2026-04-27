import 'dart:io';
import 'package:flutter/material.dart';
import '../core/auth_service.dart';

class UserProvider extends ChangeNotifier {
  // Common state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _userId;

  // Customer Data
  String _userName = ""; 
  String _userEmail = "";
  String _userPhone = "";
  String _userSSN = "";
  String _userAddress = "";
  String _userBio = "";
  File? _userImage;

  // Worker Data
  String _workerName = "";
  String _workerSSN = "";
  String _workerBio = "";
  String _workerEmail = "";
  String _workerPhone = "";
  String _workerAddress = "";
  File? _workerImage;

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  String get userSSN => _userSSN;
  String get userAddress => _userAddress;
  String get userBio => _userBio;
  File? get userImage => _userImage;

  String get workerName => _workerName;
  String get workerSSN => _workerSSN;
  String get workerBio => _workerBio;
  String get workerEmail => _workerEmail;
  String get workerPhone => _workerPhone;
  String get workerAddress => _workerAddress;
  File? get workerImage => _workerImage;

  // Setup data from API response
  void _setUserDataFromMap(Map<String, dynamic> data) {
    if (data['name'] != null) {
      if (data['name'] is Map) {
        _userName = "${data['name']['first'] ?? ''} ${data['name']['last'] ?? ''}".trim();
      } else {
        _userName = data['name'].toString();
      }
    }
    if (data['email'] != null) _userEmail = data['email'];
    if (data['phoneNumber'] != null) _userPhone = data['phoneNumber'];
    if (data['ssn'] != null) _userSSN = data['ssn'].toString();
    if (data['address'] != null) {
      if (data['address'] is Map) {
        _userAddress = "${data['address']['government'] ?? ''}, ${data['address']['city'] ?? ''}, ${data['address']['street'] ?? ''}".trim();
      } else {
        _userAddress = data['address'].toString();
      }
    }
    
    // Worker specific mapping
    if (data['role'] == 'worker') {
      _workerName = _userName;
      _workerEmail = _userEmail;
      _workerPhone = _userPhone;
      _workerAddress = _userAddress;
      if (data['ssn'] != null) _workerSSN = data['ssn'].toString();
      if (data['bio'] != null) _workerBio = data['bio'].toString();
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    final result = await AuthService.login(email, password);
    
    if (result['success']) {
      // Backend login returns email in 'data'. Load profile to get full user details.
      await loadProfile();
    }
    
    _isLoading = false;
    notifyListeners();
    return result['success'];
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    _isLoading = true;
    notifyListeners();
    
    final result = await AuthService.register(userData);
    
    if (result['success']) {
      // Backend register returns { data: { user: {...}, token: ... } }
      final data = result['data']['data']['user'];
      _userId = data['_id'];
      _setUserDataFromMap(data);
    }
    
    _isLoading = false;
    notifyListeners();
    return result['success'];
  }

  Future<bool> loadProfile() async {
    _userId ??= await AuthService.getUserId();
    if (_userId == null) return false;

    final result = await AuthService.getUserProfile(_userId!);
    if (result['success']) {
      // Assuming profile response is { data: { ...user fields... } } or { data: { user: {...} } }
      final responseData = result['data'];
      final userData = responseData['data'] ?? responseData;
      _setUserDataFromMap(userData);
      return true;
    }
    return false;
  }

  Future<bool> updateUserData({
    String? name, 
    String? email, 
    String? phone, 
    String? ssn,
    String? address, 
    String? bio, 
    File? image
  }) async {
    // Local update first for fast UI
    if (name != null) _userName = name;
    if (email != null) _userEmail = email;
    if (phone != null) _userPhone = phone;
    if (ssn != null) _userSSN = ssn;
    if (address != null) _userAddress = address;
    if (bio != null) _userBio = bio;
    if (image != null) _userImage = image;
    notifyListeners();

    if (_userId == null) return false;

    // Call API
    Map<String, dynamic> updates = {};
    if (name != null) {
      List<String> parts = name.split(' ');
      updates['name'] = {
        'first': parts[0],
        'last': parts.length > 1 ? parts.sublist(1).join(' ') : 'User'
      };
    }
    if (email != null) updates['email'] = email;
    if (phone != null) updates['phoneNumber'] = phone;
    if (ssn != null) updates['ssn'] = ssn;

    if (updates.isNotEmpty) {
       final result = await AuthService.updateProfile(_userId!, updates);
       return result['success'];
    }
    return true;
  }

  Future<bool> updateWorkerData({
    String? name, 
    String? ssn, 
    String? bio,  
    File? image, 
    String? email,
    String? phone,
    String? address
  }) async {
    if (name != null) _workerName = name;
    if (ssn != null) _workerSSN = ssn;
    if (bio != null) _workerBio = bio;
    if (image != null) _workerImage = image;
    if (email != null) _workerEmail = email;
    if (phone != null) _workerPhone = phone;
    if (address != null) _workerAddress = address;
    notifyListeners();

    if (_userId == null) return false;

    Map<String, dynamic> updates = {};
    if (name != null) {
      List<String> parts = name.split(' ');
      updates['name'] = {
        'first': parts[0],
        'last': parts.length > 1 ? parts.sublist(1).join(' ') : 'User'
      };
    }
    if (ssn != null) updates['ssn'] = ssn;
    if (email != null) updates['email'] = email;
    if (phone != null) updates['phoneNumber'] = phone;

    if (updates.isNotEmpty) {
       final result = await AuthService.updateProfile(_userId!, updates);
       return result['success'];
    }
    return true;
  }

  Future<void> logout() async {
    await AuthService.logout();
    _userId = null;
    _userName = "";
    _userEmail = "";
    _userPhone = "";
    _userAddress = "";
    _userBio = "";
    _userImage = null;

    _workerName = "";
    _workerImage = null;
    _workerSSN = "";
    _workerBio = "";
    _workerEmail = "";
    _workerPhone = "";
    _workerAddress = "";
    notifyListeners(); 
  }
}
