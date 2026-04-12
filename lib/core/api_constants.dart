// TODO Implement this library.
class ApiConstants {
  
  static const String emulatorBaseUrl = 'http://10.0.2.2:3000/api/user';

  
  static const String physicalDeviceBaseUrl =
      'http://192.168.1.3:3000/api/user';

  
  static const String baseUrl = emulatorBaseUrl;
 

  
  static const String verifyIdentity = '$baseUrl/verify-identity';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
}
