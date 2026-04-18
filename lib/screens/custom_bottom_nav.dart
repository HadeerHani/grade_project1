import 'package:flutter/material.dart';
import 'package:second_project/screens/home_screen.dart';
import 'package:second_project/screens/personal_page.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF2EFE9),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,

      selectedItemColor: AppColors.primaryDarkGreen,
      unselectedItemColor: AppColors.textgrey,
     items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        /* BottomNavigationBarItem(
          icon:Container( padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color:AppColors.primaryDarkGreen, shape: BoxShape.circle),
          child: const Icon(Icons.add,color: Colors.white,size: 30),),
           label: 'Requests'
          ),
           //Icon(Icons.add_box),
          // label: 'Requests'
        
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),label: 'Account'
        ),*/
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryDarkGreen,
              shape: BoxShape.circle,
            ),
            // Icon(Icons.assignment_outlined),
            // activeIcon: Icon(Icons.assignment),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
          label: 'Requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          //activeIcon: Icon(Icons.person),
          label: 'Account',
        ),
      ],

      onTap: (index) {
        if (index == currentIndex) return;
        if (index == 0) {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
         // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (index == 1) {
          // Navigator.pushNamed(context, '/requests');
        } else if (index == 2) {
          // Navigator.pushNamed(context, '/account');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonalPage()),
          );
        }
      },
    );
  }
}
