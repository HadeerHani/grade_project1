import 'package:second_project/screens/active_request_page.dart';
import 'package:second_project/screens/cleaning_page.dart';
import 'package:second_project/screens/custom_bottom_nav.dart';
import 'package:second_project/screens/home_repairpage.dart';
import 'package:second_project/screens/moving_page.dart';
import 'package:second_project/screens/other_services_page.dart';
import 'package:second_project/screens/personal_page.dart';
import 'package:second_project/screens/task_details_screen.dart';
import 'package:second_project/screens/services_list_screen.dart';
import 'package:second_project/screens/user_provider.dart';
import 'package:second_project/screens/vehicle_servicespage.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

import 'package:flutter/material.dart';
import 'user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ⭐️ بيانات الـ API (تتغير تلقائياً لاحقاً) ⭐️
  final String userName = "Jane";
  final int activeRequestsCount = 4;
  final String latestRequestTitle = "Unusual Request";
  final String latestRequestStatus = "Accepted";
  final String latestRequestPrice = "100";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,

      appBar: AppBar(
        title: const Text("FIXPAY"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
          // const SizedBox(width: 8),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return GestureDetector(
                onTap: () {
                  // ممكن تفتحي صفحة البروفايل لما يضغط على الصورة
                  Navigator.pushNamed(context, '/account');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.backgroundWhite,
                    // 💡 هنا بنشيك: لو فيه صورة في الـ Provider اعرضيها، لو مفيش اعرضي الأيقونة
                    backgroundImage: userProvider.userImage != null
                        ? FileImage(userProvider.userImage!)
                        : null,
                    child: userProvider.userImage == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF2EFE9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      return RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B2B2B),
                          ),
                          children: [
                            const TextSpan(text: "Good morning ☀️ , "),
                            TextSpan(text: userProvider.userName),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    "How can we help you today?",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryDarkGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2️⃣ قسم Active Requests (قابل للضغط)
            Text(
              "Active Requests ($activeRequestsCount)",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2B2B),
              ),
            ),
            const SizedBox(height: 12),
            _buildActiveRequestsCard(
              context,
            ), // نمرر الـ context هنا لتفعيل التنقل

            const SizedBox(height: 24),

            // 3️⃣ قسم Browse Categories
            const Text(
              "Browse Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2B2B),
              ),
            ),
            const SizedBox(height: 12),
            _buildCategoriesGrid(),

            const SizedBox(height: 24),

            // 4️⃣ قسم المراجعات الأخيرة
            const Text(
              "Your Recent Reviews (2)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2B2B),
              ),
            ),
            const SizedBox(height: 12),
            _buildReviewsCard(),
          ],
        ),
      ),

      // 🟢 شريط التنقل السفلي والزر العائم
      /*floatingActionButton: FloatingActionButton(///////////////////هااا
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActiveRequestPage()),
          );
        },
        backgroundColor: AppColors.primaryDarkGreen,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      ),*/
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
      //_buildBottomNav(context),
    );
  }

  // --- كارت الطلبات النشطة (Clickable) ---
  Widget _buildActiveRequestsCard(BuildContext context) {
    return InkWell(
      onTap: () {
        // الانتقال لصفحة الطلبات الكاملة عند الضغط
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveRequestsPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF2EFE9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryDarkGreen,
                  child: const Icon(
                    Icons.build,
                    color: AppColors.secondaryLightBeige,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You have $activeRequestsCount active requests",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "Tap to view status updates.",
                        style: TextStyle(
                          color: AppColors.textgrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
            const Divider(height: 24, color: AppColors.button),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  latestRequestTitle,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$latestRequestStatus - \$$latestRequestPrice", // بيانات API متغيرة
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- شبكة التصنيفات ---
  Widget _buildCategoriesGrid() {
    final List<Widget> categoryScreens = [
      // 1. Home Repair
      ServicesListScreen(
        categoryTitle: "Home Repair",
        servicesList: [
          /* {'name': 'Electrician', 'icon': Icons.bolt},
      {'name': 'Plumber', 'icon': Icons.water_drop},
      {'name': 'Carpenter', 'icon': Icons.handyman},
      {'name': 'Painter', 'icon': Icons.palette},
      {'name': 'AC Repair', 'icon': Icons.ac_unit},*/
          {'name': 'Electrician', 'icon': Icons.bolt},
          {'name': 'Plumber', 'icon': Icons.water_drop},
          {'name': 'Carpenter', 'icon': Icons.handyman},
          {'name': 'Painter', 'icon': Icons.palette},
          {'name': 'AC & Cooling Repair', 'icon': Icons.ac_unit},
          {'name': 'Appliance Repair', 'icon': Icons.tv},
          {'name': 'Door & Lock Repair', 'icon': Icons.lock_outline},
          {'name': 'Gardening & Lawn Care', 'icon': Icons.yard_outlined},
        ],
      ),

      // 2. Cleaning
      ServicesListScreen(
        categoryTitle: "Cleaning",
        servicesList: [
          {'name': 'Home Cleaning', 'icon': Icons.home},
          {'name': 'Office & Commercial Cleaning', 'icon': Icons.business},
          {'name': 'Pest Control', 'icon': Icons.bug_report},
          {'name': 'Disinfection & Sanitation', 'icon': Icons.sanitizer},
        ],
      ),

      // 3. Personal
      ServicesListScreen(
        categoryTitle: "Personal Services",
        servicesList: [
          {'name': 'Barber at Home', 'icon': Icons.content_cut},
          {'name': 'Beauty / Makeup Artist', 'icon': Icons.auto_awesome},
          {'name': 'Tailor / Clothes Repair', 'icon': Icons.checkroom},
          {'name': 'Laundry & Ironing', 'icon': Icons.local_laundry_service},
        ],
      ),

      // 4. Vehicle
      ServicesListScreen(
        categoryTitle: "Vehicle Services",
        servicesList: [
          {'name': 'Car Wash (At Home)', 'icon': Icons.directions_car},
        ],
      ),

      // 5. Moving
      ServicesListScreen(
        categoryTitle: "Moving & Logistics",
        servicesList: [
          {'name': 'Furniture Moving', 'icon': Icons.inventory_2},
          {'name': 'Delivery & Courier Services', 'icon': Icons.local_shipping},
        ],
      ),

      // 6. Others
      ServicesListScreen(
        categoryTitle: "Other Services",
        servicesList: [
          {'name': 'CCTV & Security Systems', 'icon': Icons.security},
          {
            'name': 'Smart Home Setup &Repair',
            'icon': Icons.home_repair_service,
          },
          {'name': ' Swimming Pool Maintenance', 'icon': Icons.pool},
          {'name': 'Customized Request', 'icon': Icons.more_horiz},
          {'name': 'Interior Decoration', 'icon': Icons.light_outlined},
        ],
      ),
    ];
    /* final List<Widget> categoryScreens = [
      HomeRepairpage(),
      CleaningPage(),
      PersonalPage(),
      VehicleServicespage(),
      MovingPage(),
      OtherServicesPage(),
    ];*/
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.build_outlined, 'label': 'Home Repair'},
      {'icon': Icons.home_outlined, 'label': 'Cleaning'},
      {'icon': Icons.content_cut_outlined, 'label': 'Personal'},
      {'icon': Icons.directions_car_outlined, 'label': 'Vehicle'},
      {'icon': Icons.local_shipping_outlined, 'label': 'Moving'},
      {'icon': Icons.more_horiz_outlined, 'label': 'Other'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            //  هنا الـ index بيعرف الصفحة اللي هيدخل عليها
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => categoryScreens[index]),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryDarkGreen,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categories[index]['icon'],
                  color: AppColors.secondaryLightBeige,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index]['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.secondaryLightBeige,
                    // Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- كارت المراجعات ---
  Widget _buildReviewsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFE9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFF2EFE9),
            child: Icon(Icons.star, color: Colors.orange),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reviews Given",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "You rated 2 services.",
                style: TextStyle(color: AppColors.textgrey, fontSize: 13),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}

  // --- شريط التنقل السفلي ---
  /* Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFFF2EFE9),
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, Icons.home_filled, "Home", true, null),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Requests",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
            ],
          ),
          // _navItem(Icons.assignment_outlined, "Requests", false),
           //const SizedBox(height: 60),
          _navItem(context, Icons.person_outline, "Account", false,const ProfileScreen()),
          //  _navItem(Icons.settings_outlined, "Settings", false),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isSelected,
    Widget? targetScreen,
  ) {
    return InkWell(
      onTap: () {
        if (targetScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        }
      },

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primaryDarkGreen : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? AppColors.primaryDarkGreen : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }*/
/*import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundWhite,
    );
  }
}*/
