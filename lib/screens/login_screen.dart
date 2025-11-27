import 'package:flutter/material.dart';
import 'package:second_project/screens/create_account_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              //SizedBox(height: 2,),
              const Text(
                'Log in to continue ',
                style: TextStyle(
                  fontSize: 23,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                 */
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarkGreen,
                    foregroundColor: AppColors.secondaryLightBeige,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 22),
              Center(
                child: Text(
                  'or continue with',
                  style: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(height: 17),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color.fromRGBO(56, 94, 72, 1),
                      fontSize: 19,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreateAccountScreen();
                          },
                        ),
                      );
                    },
                  
                 child: const Text('Sign up', style: TextStyle(fontSize: 19)),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
