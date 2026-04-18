import 'package:flutter/material.dart';
import 'package:second_project/screens/create_account_screen.dart';
import 'package:second_project/screens/forgot_password.dart';
import 'package:second_project/screens/home_screen.dart';
import 'package:second_project/screens/send_code_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
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
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return VerifyAccountScreen (email: _emailController.text,
                          selectedRole: 'Customer',);
                        },
                      ),
                    );
                 
                  },

                  style: ElevatedButton.styleFrom(
                    //backgroundColor: AppColors.primaryDarkGreen,
                    //foregroundColor: AppColors.secondaryLightBeige,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    /*  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),*/
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForgotPassword();
                      },
                    ),
                  );
                },
                child: Center(
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97),
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                // padding: const EdgeInsets.symmetric(horizontal: 80,),
                child: Center(
                  //width: 280,
                  //ConstrainedBox(constraints: const BoxConstraints(maxHeight: 50),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // 
                      print('Signing in with Google...');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primaryDarkGreen,
                        width: 2.0,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.symmetric(
                        horizontal: 35.0,
                        vertical: 10.0,
                      ),
                      minimumSize: Size.zero,
                      // padding: const EdgeInsets.symmetric(horizontal: 90),
                      backgroundColor: Colors.white70, 
                      foregroundColor: AppColors.primaryDarkGreen,
                      elevation: 1, 
                    ),
                    /* icon: Image.network(
               'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
               height: 24.0,
                   ),*/
                    label: const Text(
                      'Google',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

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

                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
