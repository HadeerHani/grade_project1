import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_project/screens/login_screen.dart';
import 'package:second_project/screens/select_services.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'user_provider.dart'; // تأكدي من مسار ملف البروفايدر عندك

class WorkerProfilePage extends StatefulWidget {
  final List<String> selectedSkills;
  const WorkerProfilePage({super.key, required this.selectedSkills});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  bool isEditing = false; // لمتابعة حالة التعديل

  late TextEditingController _nameController;
  late TextEditingController _ssnController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    // جلب البيانات الحالية من الـ Provider
    final wp = Provider.of<UserProvider>(context, listen: false);
    _nameController = TextEditingController(text: wp.workerName);
    _ssnController = TextEditingController(text: wp.workerSSN);
    _bioController = TextEditingController(text: wp.workerBio);
    _emailController = TextEditingController(text: wp.workerEmail);
    _phoneController = TextEditingController(text: wp.workerPhone);
    _addressController = TextEditingController(text: wp.workerAddress);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null && mounted) {
      // استخدام الدالة الشاملة الجديدة في الـ Provider
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).updateWorkerData(image: File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryDarkGreen = Color(0xFF385E48);
    const cardBackground = Color(0xFFF2EFE9);
    const Color greyLabel = Color(0xFFA59D8B);
    const Color logout = Color(0xFFC62828);

    return Consumer<UserProvider>(
      builder: (context, wp, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          appBar: AppBar(
            title: const Text("My Account"),
            actions: [
              IconButton(
                // تغيير الأيقونة بناءً على حالة التعديل
                icon: Icon(
                  isEditing ? Icons.check : Icons.edit,
                  color: AppColors.backgroundWhite,
                ),
                onPressed: () async {
                  if (isEditing) {
                    // حفظ البيانات الجديدة في الـ Provider
                    bool success = await wp.updateWorkerData(
                      name: _nameController.text,
                      ssn: _ssnController.text,
                      bio: _bioController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                    );
                    
                    if (success) {
                      setState(() => isEditing = false);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to update profile')),
                        );
                      }
                    }
                  } else {
                    setState(() => isEditing = true);
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // جزء الصورة والاسم العلوي
                _buildHeader(wp, primaryDarkGreen, cardBackground),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // كارت المعلومات الشخصية
                      SizedBox(
                        width: double.infinity,
                        child: _buildInfoCard(cardBackground, greyLabel),
                      ),
                      const SizedBox(height: 16),
                      // كارت الـ Worker Status والـ Specialties
                      _buildStatusCard(cardBackground, greyLabel),
                      const SizedBox(height: 24),
                      // زر الـ Logout
                      _buildLogoutButton(logout),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    UserProvider wp,
    Color primaryDarkGreen,
    Color cardBackground,
    //Color offWhiteText,
  ) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: cardBackground,
              backgroundImage: wp.workerImage != null
                  ? FileImage(wp.workerImage!)
                  : null,
              child: wp.workerImage == null
                  ? Text(
                      wp.workerName.isNotEmpty
                          ? wp.workerName[0].toUpperCase()
                          : "W",
                      style: const TextStyle(
                        fontSize: 55,
                        color: AppColors.primaryDarkGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            if (isEditing)
              GestureDetector(
                onTap: _pickImage,
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFF2EFE9),
                  child: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: AppColors.primaryDarkGreen,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          wp.workerName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDarkGreen,
          ),
        ),
        const Text(
          "Professional Worker",
          style: TextStyle(color: Colors.grey, letterSpacing: 1),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInfoCard(Color cardBackground, Color greyLabel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBackground, // اللون الجديد للكارد `0xFFE2EFE9`
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkGreen.withOpacity(0.02),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Information",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          //const Divider(height: 30, color: AppColors.primaryDarkGreen),
          // العرض عادي أو تعديل (يظهر Text أو TextField مدور)
          _infoRow("NAME", _nameController, "Spencer N.", greyLabel),
          _infoRow("SSN", _ssnController, "14 digits number", greyLabel),
          _infoRow("EMAIL", _emailController, "mail@example.com", greyLabel),
          _infoRow("PHONE", _phoneController, "01xxxxxxxxx", greyLabel),
          _infoRow("ADDRESS", _addressController, "City, Street", greyLabel),
          const SizedBox(height: 15),
          const Text(
            "BIO",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          isEditing
              ? TextField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Tell us about your work experience...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              : Text(
                  Provider.of<UserProvider>(context, listen: false).workerBio,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
        ],
      ),
    );
  }

  Widget _infoRow(
    String label,
    TextEditingController controller,
    String hint,
    Color greyLabel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: greyLabel,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          isEditing
              ? TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Colors.white, // خلفية الـ Field بيضاء مدورة زي الصورة
                    hintText: hint,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!.withOpacity(0.1),
                      ),
                    ),
                    /* focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Color(0xFF132F2B)),
                    ),*/
                  ),
                )
              // العرض عادي (Text) لما ميكونش تعديل
              : Text(
                  controller.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(Color cardBackground, Color greyLabel) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBackground, // اللون الجديد للكارد `0xFFE2EFE9`
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.verified, color: AppColors.primaryDarkGreen, size: 28),
              SizedBox(width: 12),
              Text(
                "Status: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Verified",
                style: TextStyle(
                  color: AppColors.primaryDarkGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 40, color: AppColors.primaryDarkGreen),
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // 1. عرض كلمة التخصصات مع العدد الحقيقي
    Text(
      "Specialties (${widget.selectedSkills.length})", // هيقرأ عدد المهارات اللي في الشنطة
      style: TextStyle(
        color: AppColors.primaryDarkGreen,
        fontWeight: FontWeight.w500,
      ),
    ),
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SelectServicesScreen(isUpdating: true,)),
        );
      },
      child: const Text(
        "Update Services",
        style: TextStyle(
          color: AppColors.textgrey,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  ],
),

        ],
      ),
    );
  }

  Widget _buildLogoutButton(Color mainGreen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Provider.of<UserProvider>(context, listen: false).logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC62828),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          "Log Out",
          style: TextStyle(
            color: AppColors.backgroundWhite,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
