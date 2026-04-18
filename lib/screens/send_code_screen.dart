import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:second_project/screens/home_screen.dart';
import 'package:second_project/screens/new_password_screen.dart';
import 'package:second_project/screens/select_services.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'package:flutter/services.dart';
//import 'package:second_project/screens/create_account_screen.dart';

class VerifyAccountScreen extends StatefulWidget {
  final String? selectedRole;
  final String email;
  const VerifyAccountScreen({super.key, this.selectedRole,required this.email});
  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreen();
}

class _VerifyAccountScreen extends State<VerifyAccountScreen> {
 // final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      appBar: AppBar(
        title: const Text('FIXPAY'),
        // toolbarHeight: 80.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text(
                "Verify your account",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryDarkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We sent a code to your email",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              //
              Text(
                "Enter 6-digit code",
                style: TextStyle(
                  color: AppColors.primaryDarkGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOTPBox(context)),
              ),

              const SizedBox(height: 40),

              // زر التحقق
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.selectedRole =='password_reset') //{
                      {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const NewPasswordScreen(),
                        ), //
                        (Route<dynamic> route) => false,
                      );
                    } else if(widget.selectedRole=='Worker') {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const SelectServicesScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                   else if(widget.selectedRole=='Customer'){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(
                           // resetToken:otpController.text ,
                          ),
                        ),
                        (Route<dynamic> route) => false,
                      );
                  }
                  },
                  
                  child: const Text(
                    "Verify Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: AppColors.secondaryLightBeige,
                    ),
                  ),
                  // style: ElevatedButton.styleFrom(
                  // backgroundColor: AppColors.primaryDarkGreen,
                  // shape: RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(30),
                ),
              ),

              /* child: const Text(
                    "Verify Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryLightBeige,
            
                    ),
                  ),*/
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      color: AppColors.primaryDarkGreen,
                      fontSize: 19,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        color: AppColors.primaryDarkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  //
  Widget _buildOTPBox(BuildContext context) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15), //
        border: Border.all(color: Colors.grey.shade400),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDarkGreen,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1), //رقم واحد فقط
          FilteringTextInputFormatter.digitsOnly, // أرقام فقط
        ],
        decoration: const InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
