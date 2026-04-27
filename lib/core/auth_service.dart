import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class AuthService {
  static const String _tokenKey = 'jwt_token';
  static const String _userIdKey =
      'user_id'; // To store the logged-in user's ID

  // --- Token Management ---
  static Future<void> saveAuthData(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
  }

  static Future<Map<String, String>> _getHeaders({
    bool includeAuth = true,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    if (includeAuth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'bearer $token';
      }
    }
    return headers;
  }

  // --- API Methods ---

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = responseData['token'];
        // The backend login returns 'data: user.email' instead of the full user object.
        // We might need to fetch the profile separately or adjust based on token decoding.
        // For now, let's just save the token.
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_tokenKey, token);

          // Try to get userId if available in response (it might not be based on controller code)
          if (responseData['data'] is Map &&
              responseData['data']['_id'] != null) {
            await prefs.setString(_userIdKey, responseData['data']['_id']);
          }
        }
        return {'success': true, 'data': responseData};
      } else {
        print('Login Error: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      print('Login Exception: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode(userData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Backend register returns { data: { user: {...}, token: "..." } }
        final data = responseData['data'];
        if (data != null) {
          final token = data['token'];
          final user = data['user'];
          if (token != null && user != null && user['_id'] != null) {
            await saveAuthData(token, user['_id']);
          }
        }
        return {'success': true, 'data': responseData};
      } else {
        print('Register Error: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registration has',
        };
      }
    } catch (e) {
      print('Register Exception: $e');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.logout),
        headers: await _getHeaders(),
      );

      await clearAuthData();

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {
          'success': false,
          'message': 'Logout failed on server, but local session cleared.',
        };
      }
    } catch (e) {
      await clearAuthData();
      return {
        'success': false,
        'message': 'Network error. Local session cleared.',
      };
    }
  }

  // --- Profile Methods ---
  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getUserProfile(userId)),
        headers: await _getHeaders(),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch profile',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse(ApiConstants.updateUserProfile(userId)),
        headers: await _getHeaders(),
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  // --- Password & Verification ---
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.forgotPassword),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({'email': email}),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to send reset code',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.resetPassword),
        headers: await _getHeaders(includeAuth: false),
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to reset password',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> confirmEmail(
    String email,
    String otp,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.confirmEmail),
        headers: await _getHeaders(includeAuth: true),
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to verify email',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }
}
