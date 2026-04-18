import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class JobDetailsScreen extends StatefulWidget {
  final String serviceName;
  const JobDetailsScreen({super.key, required this.serviceName});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  // كنترولر للتاريخ عشان يتحدث لما نختار من النتيجة
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // ميثود لإظهار النتيجة (Date Picker)
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.secondaryLightBeige,
      appBar: AppBar(
        title: Text("${widget.serviceName} Request", 
       // style: const TextStyle(color: Colors.white)
        ),
       // backgroundColor: const Color(0xFF1B2B2B), // اللون الغامق
       /* leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),*/
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("New Job Details ", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: AppColors.primaryDarkGreen)),
            const SizedBox(height: 8),
            const Text("Tell us when, where, and what needs fixing. Required fields are marked.",
                style: TextStyle(color: AppColors.textgrey, fontSize: 14)),
            const SizedBox(height: 25),

            // السطر بتاع التاريخ والوقت
            Row(
              children: [
                Expanded(
                  child: _buildInputField("Date (Required)", "02/07/2026", 
                    controller: _dateController, 
                    suffixIcon: Icons.calendar_month,
                    onTap: () => _selectDate(context), // فتح النتيجة عند الضغط
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildInputField("Time (Required)", "10:00 AM", controller: _timeController),
                ),
              ],
            ),

            const SizedBox(height: 20),
            _buildInputField("Proposed Budget (USD - Required)", "Max budget (e.g., 150)"),
            
            const SizedBox(height: 20),
            _buildInputField("Description of Job (Required)", 
                "Describe the issue in detail (e.g., Leaky pipe under the sink...)", 
                maxLines: 4),

            const SizedBox(height: 20),
            const Text("Photo Reference (Optional)", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: AppColors.primaryDarkGreen)),
            const SizedBox(height: 10),
            // مكان زرار الصورة (فاضي حالياً بناءً على طلبك)
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.button, // اللون البيج في الصورة
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_outlined,color: AppColors.primaryDarkGreen,),
                  SizedBox(width: 10),
                  Text("Add Photo of Job Site", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primaryDarkGreen)),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildInputField("Detailed Location / Access Notes (Required)", 
                "456 Customer Ave, Apt 1A, use side gate."),

            const SizedBox(height: 30),
            
            // زرار الـ Post
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarkGreen,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {},
              child: const Text("Post Job & Find Worker", style: TextStyle(color:AppColors.secondaryLightBeige, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // ميثود مساعدة لبناء الخانات (Textfields) عشان الكود يبقى منظم
  Widget _buildInputField(String label, String hint, {int maxLines = 1, TextEditingController? controller, IconData? suffixIcon, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: AppColors.primaryDarkGreen)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          readOnly: onTap != null, // لو فيه نتيجة خليه للقراءة فقط
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}