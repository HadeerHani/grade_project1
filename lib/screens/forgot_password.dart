import 'package:flutter/material.dart';
import 'package:second_project/screens/send_code_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('FIXPAY')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your email to receive a verification code.',
              style: TextStyle(fontSize: 16, color: AppColors.primaryDarkGreen),
            ),
            const SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  final String userEmail = _emailController.text;
                  final String roleFprPasswordRest = 'password_reset';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VerifyAccountScreen(
                          email:userEmail,
                          selectedRole: roleFprPasswordRest,
                         //rolee: 'password_reset',
                         //correctotp: 'your',

                        );
                      },
                    ),
                  );
                  print('Send Code button pressed...');
                },
                child: const Text(
                  'Send Code',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondaryLightBeige,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
