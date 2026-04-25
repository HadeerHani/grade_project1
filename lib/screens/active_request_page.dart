import 'package:flutter/material.dart';

class ActiveRequestPage extends StatefulWidget {
  const ActiveRequestPage({super.key});

  @override
  State<ActiveRequestPage> createState() => _ActiveRequestPageState();
}

class _ActiveRequestPageState extends State<ActiveRequestPage> {
  // ألوان التطبيق الأساسية اللي استخدمناها في الشاشات اللي فاتت
  final Color primaryDarkGreen = const Color(0xFF385E48);
  final Color cardBackground = const Color(0xFFF2EFE9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryDarkGreen,
        title: const Text(
          "Active Request",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. كارت بيانات العميل (Customer Info)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Color(0xFF385E48)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ahmed Mahmoud", // اسم العميل (ممكن يتغير من الداتا بيز)
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF385E48)),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            Text(" 4.8 (12 Reviews)", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. تفاصيل المشكلة (Job Details)
            const Text(
              "Problem Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Text(
                "Water is leaking from the main pipe in the kitchen under the sink. Need urgent fix.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),

            // 3. الموقع والوقت (Location & Time)
            const Text(
              "Job Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cardBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_on, color: primaryDarkGreen),
              ),
              title: const Text("12 Maadi Street, Cairo"),
              subtitle: const Text("2.5 km away"),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cardBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.access_time_filled, color: primaryDarkGreen),
              ),
              title: const Text("Today, 10:30 AM"),
              subtitle: const Text("Requested 15 mins ago"),
            ),
            const SizedBox(height: 30),

            // 4. زراير التواصل (Call & Chat)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {}, // حط كود المكالمة هنا
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text("Call", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkGreen,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {}, // حط كود الشات هنا
                    icon: Icon(Icons.chat, color: primaryDarkGreen),
                    label: Text("Chat", style: TextStyle(color: primaryDarkGreen)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: primaryDarkGreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 5. زرار إنهاء العمل (Complete Job)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // كود إنهاء الطلب
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF385E48),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  "Mark as Completed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}