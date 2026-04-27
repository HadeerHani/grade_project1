import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_project/screens/login_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'user_provider.dart';
import 'custom_bottom_nav.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>(); // إضافة Form Key للـ Validation

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController ssnController;
  late TextEditingController addressController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    var up = Provider.of<UserProvider>(context, listen: false);
    
    nameController = TextEditingController(text: up.userName); 
    emailController = TextEditingController(text: up.userEmail);
    phoneController = TextEditingController(text: up.userPhone);
    ssnController = TextEditingController(text: up.userSSN);
    addressController = TextEditingController(text: up.userAddress);
    bioController = TextEditingController(text: up.userBio);
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, 
      );

      if (image != null) {
        if (!mounted) return;
        Provider.of<UserProvider>(context, listen: false).updateUserData(image: File(image.path));
        print("Image picked successfully: ${image.path}");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _saveChanges() async {
    // تفعيل الفاليديشن قبل الحفظ
    if (_formKey.currentState!.validate()) {
      bool success = await Provider.of<UserProvider>(context, listen: false).updateUserData(
        name: nameController.text,
        email: emailController.text, 
        phone: phoneController.text,
        ssn: ssnController.text,
        address: addressController.text,
        bio: bioController.text,
      );
      
      if (!mounted) return;
      
      if (success) {
        setState(() {
          isEditing = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: const Text("My Account"), 
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, color: AppColors.backgroundWhite),
            onPressed: () {
              if (isEditing) {
                _saveChanges();
              } else {
                setState(() => isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form( // تغليف المحتوى بـ Form
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        return CircleAvatar(
                          radius: 55,
                          backgroundColor: const Color(0xFFF2EFE9),
                          backgroundImage: userProvider.userImage != null ? FileImage(userProvider.userImage!) : null,
                          child: userProvider.userImage == null
                              ? Text(nameController.text.isNotEmpty ? nameController.text[0].toUpperCase() : "U",
                                  style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold, 
                                  color: AppColors.primaryDarkGreen))
                              : null,
                        );
                      },
                    ),
                    if(isEditing)
                      GestureDetector(
                        onTap: _pickImage,
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(0xFFF2EFE9),
                          child: Icon(Icons.camera_alt, size: 18, color: AppColors.primaryDarkGreen),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Consumer<UserProvider>(
                builder: (context, user, child) {
                  return Text(user.userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryDarkGreen));
                },
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EFE9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Personal Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryDarkGreen)),
                    const SizedBox(height: 25),
                    _buildField(
                      "NAME", 
                      nameController, 
                      isEditing,
                      validator: (val) => val!.isEmpty ? 'Name cannot be empty' : null,
                    ),
                    _buildField(
                      "EMAIL", 
                      emailController, 
                      isEditing, 
                      isEmail: true,
                      validator: (val) => !val!.contains('@') ? 'Enter a valid email' : null,
                    ),
                    _buildField(
                      "PHONE", 
                      phoneController, 
                      isEditing,
                      validator: (val) => val!.isEmpty ? 'Phone cannot be empty' : null,
                    ),
                    _buildField(
                      "SSN", 
                      ssnController, 
                      isEditing,
                      validator: (val) => val!.length != 14 ? 'SSN must be 14 digits' : null,
                    ),
                    _buildField(
                      "ADDRESS", 
                      addressController, 
                      isEditing,
                      validator: (val) => val!.isEmpty ? 'Address cannot be empty' : null,
                    ),
                    _buildField(
                      "BIO", 
                      bioController, 
                      isEditing, 
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Log Out", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
    );
  }

  // الميثود بعد تعديلها لدعم الفاليديشن
  Widget _buildField(String label, TextEditingController controller, bool isEditMode, {bool isEmail = false, int maxLines = 1, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFBCAAA4), fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if(isEditMode)
            TextFormField(
              controller: controller,
              maxLines: maxLines,
              keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
              style: const TextStyle(fontSize: 16, color: AppColors.primaryDarkGreen),
              validator: validator, // تفعيل الـ Validator
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                errorStyle: TextStyle(height: 0.8), // تظبيط شكل الإيرور
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: Text(controller.text, style: const TextStyle(fontSize: 16, color: AppColors.primaryDarkGreen), maxLines: maxLines, overflow: TextOverflow.ellipsis),
            ),
        ],
      ),
    );
  }
}