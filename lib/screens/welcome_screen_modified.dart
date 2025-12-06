import 'package:flutter/material.dart';
import 'package:second_project/screens/create_account_screen.dart';
import 'package:second_project/screens/login_screen.dart';

class AppColors {
  static const Color primaryDarkGreen = Color(0xFF385E48);
  static const Color secondaryLightBeige = Color(0xFFE7E3D8);
  static const Color backgroundWhite = Color(0xFFE7E3D8);
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color button = Color.fromARGB(255, 218, 208, 178);
  static const Color redDotBorder = Color(0xFFD32F2F);
  static const Color lightRedBackground = Color(0xFFFAE5E5);
  static const Color textgrey = Color.fromRGBO(117, 117, 117, 1);
}

class WelcomeScreenModified extends StatelessWidget {
  const WelcomeScreenModified({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          // الأيقونات الخفيفة في الخلفية
          _buildBackgroundIcons(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 230),
                  _buildLogoAndWelcomeText(),
                  const Spacer(), // يدفع الأزرار للأسفل
                  //
                  _buildActionButtons(context),
                  const SizedBox(height: 40), // مسافة سفلية
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  النص الترحيبي
  Widget _buildLogoAndWelcomeText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //  Padding(
        // padding: const EdgeInsets.(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.construction_outlined,
              color: AppColors.primaryDarkGreen,
              size: 35,
            ),
           SizedBox(width: 5),
           // SizedBox(height: 200,),
            Text(
              'FIXPAY',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
          ],
        ),

        // ),
        const SizedBox(height: 15),

        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 97, 97, 97), // AppColors.textDark,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Your trusted platform for home services.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  //
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        //
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
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
            child: const Text('Sign In',style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,),),
          ),
        ),

        const SizedBox(height: 16),

        // زر Create an Account (البيج الفاتح)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
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
           child: const Text('Create an Account',style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,),),
          ),
        ),

        const SizedBox(height: 16),

        //Continue as Guest
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDarkGreen,
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text('Continue as Guest'),
        ),
      ],
    );
  }
  Widget _buildBackgroundIcons() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.bolt, color: AppColors.primaryDarkGreen, size: 60),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.plumbing,
                  color: AppColors.primaryDarkGreen,
                  size: 80,
                ),
              ),
              SizedBox(height: 80),
              Icon(
                Icons.cleaning_services,
                color: AppColors.primaryDarkGreen,
                size: 50,
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.carpenter,
                  color: AppColors.primaryDarkGreen,
                  size: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
