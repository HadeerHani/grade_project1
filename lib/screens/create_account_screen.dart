import 'package:flutter/material.dart';
import 'package:second_project/screens/login_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  String? _selectedRole;
  Widget buildRoleButton(String text, String role) {
    bool isSelected = _selectedRole == role;
    IconData iconData;
    if (role == 'Worker') {
      iconData = Icons.build;
    } else {
      iconData = Icons.person_2_outlined;
    }
    return Expanded(
      child: ElevatedButton.icon(
        icon: Icon(iconData, size: 20),
        label: Text(text, style: const TextStyle(fontSize: 16)),

        onPressed: () {
          setState(() {
            // تحديث الشاشة
            _selectedRole = role;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.primaryDarkGreen// const Color(0xFF5E8B7E)
              : const Color.fromARGB(255, 218, 208, 178),// const Color(0xFFF1EACD),
          foregroundColor: isSelected ? AppColors.backgroundWhite : AppColors.primaryDarkGreen,
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
          child: Column(
            spacing: 10,
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
              const Text(
                'Join Fixpay Today',
                style: TextStyle(
                  fontSize: 23,
                  color: AppColors.primaryDarkGreen,
                ),
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              Text(
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

if (_selectedRole != 'Worker')
  Padding(
    padding: const EdgeInsets.only(top: 25.0),
    child: ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 218, 208, 178),
        foregroundColor: AppColors.primaryDarkGreen,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: const Text('Continue', style: TextStyle(fontSize: 18,color: AppColors.primaryDarkGreen)),
    ),
  ),

// المنطقة الشرطية (تظهر فقط عند اختيار 'Worker')
if (_selectedRole == 'Worker') ...[
  
  const SizedBox(height: 20),
  TextFormField(
    keyboardType: TextInputType.number,
    maxLength: 9, 
    decoration: const InputDecoration(
      labelText: 'Social Security Number (Required for Worker)',
      hintText: '9-digit SSN (e.g., 123456789)',
      counterText: '',
    ),
  ),
  const SizedBox(height: 20),
  ElevatedButton.icon(
    icon: const Icon(Icons.photo_camera_outlined),
    label: const Text('Upload Profile Photo (Optional)'),
    onPressed: () {
      
    },
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: AppColors.secondaryLightBeige,
      foregroundColor: AppColors.primaryDarkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  ),
  const SizedBox(height: 20),
  // 
  TextFormField(
    maxLines: 3,
    decoration: const InputDecoration(
      labelText: 'Short Bio (Optional)',
      hintText: 'e.g., Plumber with 10 years experience',
    ),
  ),
  
  const SizedBox(height: 25),
  ElevatedButton(
    onPressed: () {
    },
    style: ElevatedButton.styleFrom(
      backgroundColor:const Color.fromARGB(255, 218, 208, 178),
      foregroundColor: AppColors.primaryDarkGreen,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    child: const Text('Continue', style: TextStyle(fontSize: 18,color: AppColors.primaryDarkGreen)),
  ),
  const SizedBox(height: 15),
],

// زر تسجيل الدخول (يظهر عندما لا يكون Worker هو المختار)
if (_selectedRole != 'Worker')
  Center(
   child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
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
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  
                 child: const Text('log in', style: TextStyle(fontSize: 19, )),),
                ],
              ),
   /* child: TextButton(
      onPressed: () {
    //
      },
      child: const Text("Already have an account? Log in",style: TextStyle(fontSize: 18,color: AppColors.primaryDarkGreen),),
    ),*/
  ),
   ],
          ),
        ),
      ),
    );
  }
}
