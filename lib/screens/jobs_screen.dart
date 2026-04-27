import 'package:flutter/material.dart';
import 'package:second_project/screens/task_details_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'account_screen.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  const AppCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}

class JobsScreen extends StatelessWidget {
  final List<String> selectedSkills;
  const JobsScreen({super.key, required this.selectedSkills});

  // لستة بيانات وهمية للتجربة (Dummy Data)
  final List<Map<String, dynamic>> allJobs = const [
    {
      'title': 'Outdoor Circuit Breaker',
      'specialty': 'Electrician',
      'price': 250,
      'details': 'Need a dedicated 20A circuit run to the new shed.',
      'location': 'East Suburbs, 15 mi',
      'posted': 'Posted 3h ago',
      'icon': Icons.lightbulb_outline,
    },
    {
      'title': 'Kitchen Sink Leak',
      'specialty': 'Plumber',
      'price': 150,
      'details':
          'Fixing a major leak under the kitchen sink and replacing the pipe.',
      'location': 'West Coast, 10 mi',
      'posted': 'Posted 5h ago',
      'icon': Icons.water_drop,
    },
    {
      'title': 'Unusual Request',
      'specialty': 'Customized Request',
      'price': 100,
      'details':
          'Need someone to assemble complex Swedish flat-pack furniture.',
      'location': 'North City, 5 mi',
      'posted': 'Posted 2h ago',
      'icon': Icons.auto_fix_high,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // منطق الفلترة: بنعرض الشغل اللي تخصصه موجود في مهارات اليوزر بس
    final filteredJobs = allJobs.where((job) {
      return selectedSkills.contains(job['specialty']);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      extendBody: true,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            _buildHeader(),

            // لو مفيش وظائف تناسب المهارات
            if (filteredJobs.isEmpty)
              _buildEmptyState(context)
            else
              // عرض الوظائف المفلترة كقائمة (List) فوق
              ...filteredJobs.map(
                (job) => _buildJobCard(
                  context,
                  title: job['title'],
                  specialty: job['specialty'],
                  price: job['price'],
                  details: job['details'],
                  location: job['location'],
                  posted: job['posted'],
                  icon: job['icon'],
                ),
              ),

            const SizedBox(height: 20),
            // قسم الـ Feedback في الآخر خالص تحت
            _buildRatingsSection(),
            const SizedBox(height: 100), // مساحة عشان الـ Bottom Nav Bar
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Jobs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Showing tasks matching your: ${selectedSkills.join(", ")}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(
    BuildContext context, {
    required String title,
    required String specialty,
    required int price,
    required String details,
    required String location,
    required String posted,
    required IconData icon,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.button, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDarkGreen,
                    ),
                  ),
                ],
              ),
              Text(
                '\$$price',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // الـ Tag بتاع التخصص زي الفيديو
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryDarkGreen.withOpacity(0.1),
              //const Color(0xFFDDE3D5),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(
                    0,
                    3,
                  ), // اتجاه الظل لتحت عشان يبرز الكارد
                ),
              ],
            ),
            child: Text(
              specialty.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E7153),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            details,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Text(
                    posted,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: AppColors.primaryDarkGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                //onPressed: () {},
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsScreen(
                        title: title,
                        price: price,
                        details: details,
                        specialty: specialty,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View Details & Act',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsSection() {
    // 1. عرفي اللستة هنا (جوه الميثود) عشان الأخطاء الحمراء تروح
    final List<Map<String, String>> allRatings = [
      {'rating': '4.0 from Jane D.', 'date': 'Sep 28, 2025'},
      {'rating': '5.0 from Mark R.', 'date': 'Oct 1, 2025'},
    ];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Latest Ratings (${allRatings.length})', // الرقم هيتعدل لوحده لـ 2
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          const Divider(height: 20, color: AppColors.primaryDarkGreen),

          // 2. اللوب اللي بيعرض التقييمات والتواريخ
          ...allRatings
              .map((r) => _buildRatingItem(r['rating']!, r['date']!))
              ,
        ],
      ),
    );
  }

  Widget _buildRatingItem(String rating, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.button, size: 18),
              const SizedBox(width: 5),
              Text(
                rating,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
            ],
          ),
          Text(
            date,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Icon(Icons.work_off_outlined, size: 70, color: AppColors.button),
            const SizedBox(height: 10),
            Text(
              "No jobs for your specialties yet.",
              style: TextStyle(color: AppColors.primaryDarkGreen, fontSize: 18),
            ),
            // النص الرصاصي الصغير اللي كان ناقصك
            const SizedBox(height: 8), // مسافة صغيرة
            const Text(
              'Check back later or update your profile services.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textgrey,
                // Colors.grey,
                fontSize: 14,
              ),
            ),

            SizedBox(height: 24), // مسافة قبل الزرار
            // الزرار اللي هيودي للبروفايل
            ElevatedButton(
              onPressed: () {
                // هيروح لصفحة البروفايل علطول
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkerProfilePage(selectedSkills: []),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                //const Color(0xFFE0D4AD), // لون الزرار البيج من التصميم
                foregroundColor: AppColors.primaryDarkGreen, // لون الكتابة
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Update Specialties',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryDarkGreen,
      title: const Text(
        'FIXPAY',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
         // color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.backgroundWhite,
          ),
          onPressed: () {},
        ),
InkWell(
  onTap: () {
    // هنا هتحطي الـ Navigation لصفحة الـ Account بعدين
    print("Go to Account"); 
  },
  borderRadius: BorderRadius.circular(20), 
  child: Padding(
    padding: const EdgeInsets.all(8.0), 
    child: CircleAvatar(
      radius: 16, 
      backgroundColor: AppColors.backgroundWhite, 
      child: Icon(
        Icons.notifications_none,
        size: 20,
        color: AppColors.primaryDarkGreen, 
      ),
      // --- ده السطر اللي هيفعل الصورة الحقيقية بعدين ---
      // backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
    ),
  ),
),
    InkWell(
  onTap: () {
    // التنقل لصفحة الحساب (البروفايل)
    print("Go to Account");
  },
  borderRadius: BorderRadius.circular(20),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.backgroundWhite,
          // هنا بنربط مع الـ workerImage اللي في الـ Provider بتاعك
          backgroundImage: userProvider.workerImage != null 
              ? FileImage(userProvider.workerImage!) 
              : null,
          child: userProvider.workerImage == null 
              ? Icon(
                  Icons.person,
                  size: 20,
                  color: AppColors.primaryDarkGreen, // لون الأيقونة لما ميكونش فيه صورة
                )
              : null,
        );
      },
    ),
  ),
),   // استبدال الـ IconButton التالت بالـ InkWell والـ CircleAvatar
 
      ],
    );
  }
}
