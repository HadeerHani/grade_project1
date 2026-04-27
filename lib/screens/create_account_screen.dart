import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // مكتبة اختيار الصور
import 'dart:io'; // للتعامل مع الملفات
import 'package:provider/provider.dart';
import 'package:second_project/screens/user_provider.dart';
import 'package:second_project/screens/login_screen.dart';
import 'package:second_project/screens/send_code_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String? _selectedRole;

  // 1. تعريف متغير لحفظ الصورة والـ ImagePicker
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ssnController.dispose();
    bioController.dispose();
    super.dispose();
  }

  // 2. دالة اختيار الصورة من المعرض
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // لتقليل حجم الصورة
      );
      if (pickedFile != null) {
        setState(() {
          _profileImage = pickedFile;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Widget buildRoleButton(String text, String role) {
    bool isSelected = _selectedRole == role;
    IconData iconData = role == 'Worker'
        ? Icons.build
        : Icons.person_2_outlined;

    return Expanded(
      child: ElevatedButton.icon(
        icon: Icon(iconData, size: 20),
        label: Text(text, style: const TextStyle(fontSize: 16)),
        onPressed: () {
          setState(() {
            _selectedRole = role;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.primaryDarkGreen
              : const Color.fromARGB(255, 218, 208, 178),
          foregroundColor: isSelected
              ? AppColors.backgroundWhite
              : AppColors.primaryDarkGreen,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 100),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDarkGreen,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Join Fixpay Today',
                  style: TextStyle(
                    fontSize: 23,
                    color: AppColors.primaryDarkGreen,
                  ),
                ),
                const SizedBox(height: 20),
                // خانات الإدخال الأساسية
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your full name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) => (value == null || !value.contains('@'))
                      ? 'Please enter a valid email'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_android_outlined),
                  ),
                  validator: (value) => (value!.length < 10)
                      ? 'Please enter a valid phone number'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) => (value!.length < 6)
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) => (value != passwordController.text)
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ssnController,
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  decoration: const InputDecoration(
                    labelText: 'Social Security Number (14 digits)',
                    counterText: '',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (value) =>
                      (value!.length != 14) ? 'SSN must be 14 digits' : null,
                ),
                const SizedBox(height: 20),
                const Text(
                  'I am a :',
                  style: TextStyle(
                    color: AppColors.primaryDarkGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    buildRoleButton('Worker', 'Worker'),
                    const SizedBox(width: 15),
                    buildRoleButton('Customer', 'Customer'),
                  ],
                ),

                // عرض الحقول الإضافية في حال اختيار Worker
                if (_selectedRole == 'Worker') ...[
                  const SizedBox(height: 20),

                  // 3. تعديل زرار رفع الصورة ليظهر حالة الرفع أو المعاينة
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: _profileImage == null
                        ? const Icon(Icons.photo_camera_outlined)
                        : const Icon(Icons.check_circle, color: Colors.green),
                    label: Text(
                      _profileImage == null
                          ? 'Upload Profile Photo (Optional)'
                          : 'Photo Selected ✅',
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.white70,
                      foregroundColor: AppColors.primaryDarkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),

                  // معاينة الصورة المختارة (اختياري)
                  if (_profileImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(_profileImage!.path),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: bioController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Short Bio (Optional)',
                      hintText: 'e.g., Plumber with 10 years experience',
                    ),
                  ),
                ],

                const SizedBox(height: 25),
                // زر الاستمرار
                ElevatedButton(
                  onPressed: () async {
                    if (_selectedRole == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a role')),
                      );
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      final provider = Provider.of<UserProvider>(context, listen: false);
                      
                      // Split name into first and last for the backend
                      List<String> nameParts = fullNameController.text.trim().split(' ');
                      String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
                      String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'User';

                      // Prepare data according to backend registerSchema
                      Map<String, dynamic> userData = {
                        'name': {
                          'first': firstName,
                          'last': lastName,
                        },
                        'userName': '${firstName.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch % 10000}',
                        'email': emailController.text.trim(),
                        'phoneNumber': phoneController.text.trim(),
                        'password': passwordController.text,
                        'confirmPassword': confirmPasswordController.text,
                        'dateOfBirth': '01-01-2000', // Placeholder - backend requires DD-MM-YYYY
                        'gender': false, // Placeholder - false for male
                        'role': _selectedRole == 'Worker' ? 'worker' : 'user',
                        'ssn': ssnController.text.trim(),
                      };

                      if (_selectedRole == 'Worker') {
                        // Optional bio or category can be added here if needed
                      }
                      
                      bool success = await provider.register(userData);
                      
                      if (!context.mounted) return;
                      
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyAccountScreen(
                              email: emailController.text,
                              selectedRole: _selectedRole!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registration failed. Please check your data or try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 218, 208, 178),
                    foregroundColor: AppColors.primaryDarkGreen,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 18)),
                ),

                if (_selectedRole != 'Worker') ...[
                  const SizedBox(height: 15),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 19),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          child: const Text(
                            'log in',
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
