class ApiConstants {
  // 1. If you are using the Android Emulator
  static const String emulatorBaseUrl = 'http://192.168.1.2:3000/api';

  // 2. If you are using a Physical Device (e.g., your phone)
  // Use your computer's local IP: 192.168.1.2
  static const String physicalDeviceBaseUrl = 'http://192.168.1.2:3000/api';

  // ==========================================
  // Change this to emulatorBaseUrl if using emulator,
  // or physicalDeviceBaseUrl if using your phone.
  static const String baseUrl = physicalDeviceBaseUrl;
  // ==========================================

  // --- User Module Endpoints ---
  static const String userBaseUrl = '$baseUrl/user';
  static const String categories = '$baseUrl/categories';

  static const String register = '$userBaseUrl/register';
  static const String login = '$userBaseUrl/login';
  static const String logout = '$userBaseUrl/logout';
  static const String confirmEmail = '$userBaseUrl/confirmEmail';
  static const String resendConfirmationOtp =
      '$userBaseUrl/resend-confirmation-otp';
  static const String verifyIdentity = '$userBaseUrl/verify-identity';
  static const String forgotPassword = '$userBaseUrl/forgotPassword';
  static const String resetPassword = '$userBaseUrl/resetPassword';
  static const String uploadProfileImage = '$userBaseUrl/upload';
  static const String tasks = '$baseUrl/tasks';
  static const String openTasks = '$baseUrl/tasks/open';

  static String getUserProfile(String id) => '$userBaseUrl/$id';
  static String updateUserProfile(String id) => '$userBaseUrl/$id';
}
