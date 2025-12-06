// password_reset_success_screen.dart
import 'package:flutter/material.dart';
import 'package:second_project/screens/login_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.flash_on_rounded, 
                size: 80,
                color: AppColors.primaryDarkGreen, 
              ),
              const SizedBox(height: 30),
              const Text(
                'Password Reset Successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your password has been successfully reset. Please log in with your new credentials.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.textgrey,
                ),
              ),
              const SizedBox(height: 60),
              
              // زر "Go to Login"
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55), 
                ),
                child: const Text(
                  'Go to Login',
                  style: TextStyle(fontSize: 18, color: AppColors.secondaryLightBeige),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}