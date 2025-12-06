import 'package:flutter/material.dart';
//import 'package:second_project/screens/account_screen.dart';
//import 'package:second_project/screens/earnings_screen.dart';
//import 'package:second_project/screens/jobs_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'package:second_project/screens/worker_verification_screen.dart';

class Verification2Screen extends StatefulWidget {
  const Verification2Screen({super.key});
  @override
  State<Verification2Screen> createState() => _Verification2ScreenState();
}

class _Verification2ScreenState extends State<Verification2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixpay'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            color: AppColors.secondaryLightBeige,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_rounded),
            color: AppColors.secondaryLightBeige,
          ),
        ],
        //toolbarHeight: 80.0,
      ),
      backgroundColor: AppColors.secondaryLightBeige,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification Required',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),

              decoration: BoxDecoration(
                color: AppColors.lightRedBackground,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.redDotBorder,
                  style: BorderStyle.solid,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outlined,
                    color: AppColors.redDotBorder,
                    size: 33,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Access Restricted',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.redDotBorder,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'You must complete the verification process to view and accept tasks.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WorkerVerificationScreen();
                          },
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redDotBorder,
                      foregroundColor: AppColors.backgroundWhite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Go to Verification',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //(BottomNavigationBar)
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundWhite,
        selectedItemColor: AppColors.primaryDarkGreen,
        unselectedItemColor: Colors.grey,
        elevation: 5,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Jobs'),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),*/
    );
  }
}
