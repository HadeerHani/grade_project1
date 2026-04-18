/*import 'package:flutter/material.dart';
import 'package:second_project/screens/request_details_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
class HomeRepairpage extends StatelessWidget {
  const HomeRepairpage({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة بأسماء الخدمات والأيقونات زي الصورة بالظبط
    final List<Map<String, dynamic>> services = [
      {'name': 'Electrician', 'icon': Icons.bolt},
      {'name': 'Plumber', 'icon': Icons.water_drop},
      {'name': 'Carpenter', 'icon': Icons.handyman},
      {'name': 'Painter', 'icon': Icons.palette},
      {'name': 'AC & Cooling Repair', 'icon': Icons.ac_unit},
      {'name': 'Appliance Repair', 'icon': Icons.tv},
      {'name': 'Door & Lock Repair', 'icon': Icons.lock_outline},
      {'name': 'Gardening & Lawn Care', 'icon': Icons.yard_outlined},
    ];

    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,//const Color(0xFFF2EFE9), 
      appBar: AppBar(
        title: const Text("Home Repair",// style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
       // backgroundColor: const Color(0xFF1B2B2B), // نفس اللون الأخضر الغامق
      /*  leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),*/
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceItem(context, services[index]);
        },
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFE9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)], // الظل الخفيف
      ),
      child: ListTile(
        leading: Icon(service['icon'], color: AppColors.primaryDarkGreen),
        title: Text(service['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: AppColors.primaryDarkGreen)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // 🚀 الانتقال لنفس الصفحة مع تمرير اسم الخدمة
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsScreen(serviceName: service['name']),
            ),
          );
        },
      ),
    );
  }
}*/
