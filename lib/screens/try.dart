/*import 'package:flutter/material.dart';
import 'package:second_project/screens/worker_verification_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
class WorkerVerificationScreen extends StatefulWidget {
  const WorkerVerificationScreen({super.key});

  @override
  State<WorkerVerificationScreen> createState() => _WorkerVerificationScreenState();
}

class _WorkerVerificationScreenState extends State<WorkerVerificationScreen> {
  bool isIdUploaded = false;
  bool isSelfieCaptured = false;
  Widget _buildVerificationTile({
    required int stepNumber,
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    required bool isDone,
    required VoidCallback onPressed,
  }) {
    Color statusColor = isDone ? AppColors.primaryDarkGreen : Colors.grey;
    String statusText = isDone ? (stepNumber == 1 ? 'Uploaded' : 'Captured') : buttonText;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
              color: AppColors.textDark,
            ),
          ), 
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ), 
          const SizedBox(height: 15),
          isDone
              ? Row(
                  children: [
                    Icon(Icons.check_circle, color: statusColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Document $statusText successfully.',
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
                  label: Text(statusText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundWhite,
                    foregroundColor: AppColors.primaryDarkGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.primaryDarkGreen, width: 1),
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
                color: AppColors.textDark,
              ),
            ), 
            const SizedBox(height: 25),
            _buildVerificationTile(
              stepNumber: 1,
              title: 'Upload ID',
              description: "Upload a government-issued ID (e.g., Driver's License or Passport).",
              buttonText: 'Upload ID',
              icon: Icons.upload_file,
              isDone: isIdUploaded,
              onPressed: () {//code
                setState(() {
                  isIdUploaded = true;
                });
              },
            ), 
            _buildVerificationTile(
              stepNumber: 2,
              title: 'Take a Selfie',
              description: 'Take a clear photo of yourself for verification purposes.',
              buttonText: 'Open Camera',
              icon: Icons.camera_alt_outlined,
              isDone: isSelfieCaptured,
              onPressed: () {//code
                setState(() {
                  isSelfieCaptured = true;
                });
              },
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isVerificationComplete ? () {
              
                } : null, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDarkGreen,
                  foregroundColor: AppColors.backgroundWhite,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ), 
                child: const Text(
                  'Complete Verification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ), 
            ), 
            
            if (!isVerificationComplete) const SizedBox(height: 10),
            if (!isVerificationComplete) 
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Missing Documents',
                    style: TextStyle(
                      color: AppColors.redDotBorder,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                ), 
              ), 
          ],
        ), 
      ), 
    ); 
  } // End of build
} // End of _WorkerVerificationScreenState
*/