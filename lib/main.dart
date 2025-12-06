import 'package:flutter/material.dart';
//import 'package:second_project/color.dart';
import 'package:second_project/screens/color_screen.dart';
import 'package:second_project/screens/create_account_screen.dart';
import 'package:second_project/screens/forgot_password.dart';
import 'package:second_project/screens/jobs_screen.dart';
//import 'package:second_project/fix.dart';
import 'package:second_project/screens/login_screen.dart';
import 'package:second_project/screens/main_aej_screen.dart';
import 'package:second_project/screens/select_services.dart';
import 'package:second_project/screens/send_code_screen.dart';
import 'package:second_project/screens/verefication2_screen.dart';
//import 'package:second_project/verification1_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'package:second_project/screens/worker_verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.color
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Container();
        };
        return child!;
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.backgroundWhite),
          toolbarHeight: 80.0,
          titleTextStyle: TextStyle(
            color: AppColors.secondaryLightBeige,
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppColors.primaryDarkGreen,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //padding: const EdgeInsets.symmetric(vertical: 12,horizontal:15 ),
            backgroundColor: AppColors.primaryDarkGreen,
            foregroundColor: AppColors.secondaryLightBeige,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style:
              TextButton.styleFrom(
                foregroundColor: AppColors.primaryDarkGreen,
              ).copyWith(
                overlayColor: MaterialStateProperty.resolveWith<Color?>((
                  Set<MaterialState> states,
                ) {
                  if (states.contains(MaterialState.pressed)) {
                    return AppColors.primaryDarkGreen.withOpacity(0.2);
                  }
                  return null;
                }),
              ),
        ),

        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primaryDarkGreen,
          selectionHandleColor: AppColors.primaryDarkGreen,
          selectionColor: AppColors.primaryDarkGreen.withOpacity(0.3),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: AppColors.primaryDarkGreen),
          hintStyle: TextStyle(color: AppColors.primaryDarkGreen),
          prefixIconColor:
              AppColors.primaryDarkGreen, // AppColors.primaryDarkGreen,
          suffixIconColor: AppColors.textgrey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white70.withOpacity(0.1)),
            // width: 1.0,)
            // (
            // color: Colors.white70,
            // width: 2.0,
            // ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.primaryDarkGreen.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
      ),
      home: WelcomeScreenModified(),
    );
  }
}
