class ApiConstants {
  // 1. لو بتجرب على المحاكي (Emulator)
  static const String emulatorBaseUrl = 'http://10.0.2.2:3000/api/user';

  // 2. لو بتجرب على الموبايل الحقيقي (Oppo Reno 13F)
  // (متنساش تحدث الـ IP ده لو الراوتر غيرهولك بعدين)
  static const String physicalDeviceBaseUrl =
      'http://192.168.1.3:3000/api/user';

  // 3. السيرفر الحقيقي (لما حسين يرفع الباك إيند على استضافة زي Render أو AWS)
  static const String productionBaseUrl = 'https://fixpay-api.com/api/user';

  // ==========================================
  // اللينك الأساسي اللي الأبلكيشن كله هيقرا منه
  // (غير الكلمة دي بس حسب إنت بتجرب فين دلوقتي)
  static const String baseUrl = physicalDeviceBaseUrl;
  // ==========================================

  // الراوتس (Endpoints) الخاصة باليوزر
  static const String verifyIdentity = '$baseUrl/verify-identity';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
}
