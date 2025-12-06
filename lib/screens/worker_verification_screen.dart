import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // لفتح الكاميرا والمعرض
import 'package:http/http.dart' as http; // لتحميل الملفات إلى الخادم
import 'dart:io'; // للتعامل مع الملفات
import 'package:second_project/screens/welcome_screen_modified.dart';

class WorkerVerificationScreen extends StatefulWidget {
  const WorkerVerificationScreen({super.key});

  @override
  State<WorkerVerificationScreen> createState() =>
      _WorkerVerificationScreenState();
}

class _WorkerVerificationScreenState extends State<WorkerVerificationScreen> {
  bool isIdUploaded = false;
  bool isSelfieCaptured = false;

  // 💡 تعريف الـ ImagePicker
  final ImagePicker _picker = ImagePicker();

  // 💡 عنوان API الخادم (يجب عليكِ تغييره للرابط الفعلي)
  final String uploadUrl = 'YOUR_UPLOAD_API_URL';
  void _uploadId() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      // 1. إنشاء طلب التحميل (Multipart Request)
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

      // 2. إضافة الملف
      request.files.add(
        await http.MultipartFile.fromPath(
          'document_file', // اسم حقل الملف في الـ API
          file.path,
        ),
      );

      try {
        var response = await request.send();

        // 3. التحقق من استجابة الخادم
        if (response.statusCode == 200) {
          // 4. نجاح التحميل: تحديث الحالة
          setState(() {
            isIdUploaded = true;
          });
          print("ID uploaded successfully!");
        } else {
          // فشل التحميل
          print("ID upload failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print("An error occurred during ID upload: $e");
      }
    }
  }
  void _takeSelfie() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(
        await http.MultipartFile.fromPath(
          'selfie_file', // اسم حقل الملف في الـ API
          photo.path,
        ),
      );
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          setState(() {
            isSelfieCaptured = true;
          });
          print("Selfie uploaded successfully!");
        } else {
          print("Selfie upload failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print("An error occurred during selfie upload: $e");
      }
    }
  }
  Widget _buildVerificationTile({
    required int stepNumber,
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    required bool isDone,
    required VoidCallback onPressed,
  }) {
    Color statusColor = AppColors.primaryDarkGreen;
    String statusText = isDone
        ? (stepNumber == 1
              ? 'Document Uploaded successfully.'
              : 'Selfie Captured successfully.')
        : buttonText;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$stepNumber. $title',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          const SizedBox(height: 5),

          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 15),

          isDone
              ? Row(
                  children: [
                    Icon(Icons.check_circle, color: statusColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon, color: AppColors.primaryDarkGreen, size: 20),
                  label: Text(buttonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.button, 
                    foregroundColor: AppColors.primaryDarkGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final bool isVerificationComplete = isIdUploaded && isSelfieCaptured;
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Worker Verification'),
        backgroundColor: AppColors.primaryDarkGreen,
        foregroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete your profile to accept jobs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 30),
            _buildVerificationTile(
              stepNumber: 1,
              title: 'Upload ID',
              description:
                  "Upload a government-issued ID (e.g., Driver's License or Passport).",
              buttonText: 'Upload ID',
              icon: Icons.upload_file,
              isDone: isIdUploaded,
              onPressed: _uploadId, 
            ),
            _buildVerificationTile(
              stepNumber: 2,
              title: 'Take a Selfie',
              description:
                  'Take a clear photo of yourself for verification purposes.',
              buttonText: 'Open Camera',
              icon: Icons.camera_alt_outlined,
              isDone: isSelfieCaptured,
              onPressed:
                  _takeSelfie, 
            ),
            const SizedBox(height:20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isVerificationComplete
                    ? () {
                        
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDarkGreen,
                  foregroundColor: AppColors.secondaryLightBeige,
                  disabledBackgroundColor: AppColors.button,
                  //foregroundColor: finalButtonTextColor,
                  disabledForegroundColor: AppColors.primaryDarkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  isVerificationComplete
                      ? 'Complete Verification'
                      : 'Missing Documents',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
