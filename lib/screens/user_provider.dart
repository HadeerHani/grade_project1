
import 'dart:io';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // بيانات الـ User
  String _userName = "Jane"; 
  String _userEmail = "user@mail.com";
  String _userPhone = "01xxxxxxxxx";
  String _userAddress = "Cairo, Egypt";
  String _userBio = "Hello, I am using this app!";
  File? _userImage;

  // بيانات الـ Worker
  String _workerName = "Spencer N.";
  String _workerSSN = "5678";
  String _workerBio = "Certified Electrician";
  String _workerEmail = "example@mail.com";
  String _workerPhone = "0123456789";
  String _workerAddress = "Cairo, Egypt";
  File? _workerImage;

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
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

  void updateUserData({
    String? name, 
    String? email, 
    String? phone, 
    String? address, 
    String? bio, 
    File? image
  }) {
    if (name != null) _userName = name;
    if (email != null) _userEmail = email;
    if (phone != null) _userPhone = phone;
    if (address != null) _userAddress = address;
    if (bio != null) _userBio = bio;
    if (image != null) _userImage = image;
    
    notifyListeners();
  }

 /* void updateImage(File newImage) {
    _userImage = newImage;
    notifyListeners();
  }*/

  // الدالة اللي صفحة الـ Worker Profile بتنادي عليها
  void updateWorkerData({String? name, String? ssn, String? bio,  File? image ,String ?email,String? phone,String? address}) {
    if (name != null) _workerName = name;
    if (ssn != null) _workerSSN = ssn;
    if (bio != null) _workerBio = bio;
    if (image != null) _workerImage = image;
    if (email != null) _workerEmail = email;
  if (phone != null) _workerPhone = phone;
  if (address != null) _workerAddress = address;
    notifyListeners();
  }
  void logout() {
  _userName = "User Name";
  _userEmail = "";
    _userPhone = "";
    _userAddress = "";
    _userBio = "";
  _userImage = null;
  _workerName = "Worker Name";
  _workerImage = null;
  _workerSSN = "";
  _workerBio = "";
  _workerEmail = "example@mail.com";
_workerPhone = "0123456789";
_workerAddress = "Cairo, Egypt";
  notifyListeners(); // عشان كل الشاشات ترجع "فاضية" فوراً
}
}
