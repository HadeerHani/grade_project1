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
  const VerifyAccountScreen({super.key, this.selectedRole, required this.email});
  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreen();
}

class _VerifyAccountScreen extends State<VerifyAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _showError = false;

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getOTP() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  bool _isOTPComplete() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      appBar: AppBar(
        title: const Text('FIXPAY'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  "Enter 6-digit code",
                  style: TextStyle(
                    color: AppColors.primaryDarkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) => _buildOTPBox(context, index)),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_isOTPComplete()) {
                        setState(() {
                          _showError = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter the complete 6-digit code'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (widget.selectedRole == 'password_reset') {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const NewPasswordScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else if (widget.selectedRole == 'Worker') {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SelectServicesScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else if (widget.selectedRole == 'Customer') {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
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
                      ),
                    ),
                  ),
                ),
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
                      onPressed: () {
                        // مسح كل الحقول
                        for (var controller in _otpControllers) {
                          controller.clear();
                        }
                        setState(() {
                          _showError = false;
                        });
                        _focusNodes[0].requestFocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code resent to your email'),
                            backgroundColor: AppColors.primaryDarkGreen,
                          ),
                        );
                      },
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
      ),
    );
  }

  Widget _buildOTPBox(BuildContext context, int index) {
    bool hasError = _otpControllers[index].text.isEmpty && _showError;
    
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: hasError 
              ? Colors.red 
              : (_otpControllers[index].text.isEmpty ? Colors.grey.shade400 : AppColors.primaryDarkGreen),
          width: hasError ? 2 : (_otpControllers[index].text.isEmpty ? 1 : 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        onChanged: (value) {
          setState(() {
            _showError = false;
          });
          if (value.length == 1 && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
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
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}