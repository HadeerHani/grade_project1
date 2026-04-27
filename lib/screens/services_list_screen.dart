import 'package:flutter/material.dart';
import 'package:second_project/screens/custom_bottom_nav.dart';
import 'package:second_project/screens/request_details_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class ServicesListScreen extends StatelessWidget {
  final String categoryTitle;
  final List<Map<String, dynamic>> servicesList;

  const ServicesListScreen({
    super.key,
    required this.categoryTitle,
    required this.servicesList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.secondaryLightBeige, // اللون البيج اللي في الصور
      appBar: AppBar(
        title: Text(
          categoryTitle,
          // style: const TextStyle(color: Colors.white)
        ),
        // backgroundColor: const Color(0xFF1B2B2B), // اللون الأخضر الغامق
        //iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, 
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Select the exact service you need:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen, 
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: servicesList.length,
              itemBuilder: (context, index) {
                final service = servicesList[index];
                return Card(
                  color: const Color(0xFFF2EFE9),
                  // shadowColor: Colors.black.withOpacity(0.03),
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(
                      service['icon'],
                      color: AppColors.primaryDarkGreen,
                    ),
                    title: Text(
                      service['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primaryDarkGreen,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // 🚀 الربط مع صفحة التفاصيل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JobDetailsScreen(serviceName: service['name']),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }
}
