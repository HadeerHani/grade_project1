import 'package:flutter/material.dart';
import 'package:second_project/screens/password_reset_succcess_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
class NewPasswordScreen extends StatefulWidget {
  // 
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('FIXPAY')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Set New Password',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const Text(
              'Enter and Confirm your new Strong Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password(min 8 chars)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final password = _passwordController.text;
                final confirmPassword = _confirmPasswordController.text;

                if (password != confirmPassword) {
                  // عرض رسالة خطأ
                  print('');
                  return;
                }

                // قم بتنفيذ منطق إعادة تعيين كلمة المرور هنا
                print('كلمة المرور الجديدة: $password');
                // بعد النجاح، يمكنك التنقل إلى شاشة تسجيل الدخول
                bool resetSuccess = true;
                if(resetSuccess){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute
                  (builder: (context)=>const PasswordResetSuccessScreen() ), (Route<dynamic>route)=>false,);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text(
                'Reset Password',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
