import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:second_project/screens/main_aej_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'package:second_project/core/api_constants.dart';
import 'package:second_project/core/auth_service.dart';

class WorkerVerificationScreen extends StatefulWidget {
  final List<String> selectedSkills;
  const WorkerVerificationScreen({super.key, required this.selectedSkills});

  @override
  State<WorkerVerificationScreen> createState() =>
      _WorkerVerificationScreenState();
}

class _WorkerVerificationScreenState extends State<WorkerVerificationScreen> {
  bool isIdUploaded = false;
  bool isSelfieCaptured = false;
  bool isLoading = false;

  XFile? _idFile;
  XFile? _selfieFile;
  List<dynamic> _categories = [];
  String? _selectedCategoryId;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  bool _isFetchingCategories = false;

  final ImagePicker _picker = ImagePicker();

  final String uploadUrl = ApiConstants.verifyIdentity;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  void dispose() {
    _bioController.dispose();
    _ssnController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    setState(() => _isFetchingCategories = true);
    try {
      final response = await http.get(Uri.parse(ApiConstants.categories));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        List<dynamic> fetchedCategories = [];

        if (decodedData is List) {
          fetchedCategories = decodedData;
        } else if (decodedData is Map<String, dynamic>) {
          if (decodedData.containsKey('data') && decodedData['data']['categories'] != null) {
            fetchedCategories = decodedData['data']['categories'];
          } else if (decodedData.containsKey('categories')) {
            fetchedCategories = decodedData['categories'];
          } else {
            debugPrint('Error: Unknown JSON Map structure: $decodedData');
          }
        }

        setState(() {
          _categories = fetchedCategories;
        });
      } else {
        debugPrint('Failed to fetch categories. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    } finally {
      setState(() => _isFetchingCategories = false);
    }
  }

  void _uploadId() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (file != null) {
        setState(() {
          _idFile = file;
          isIdUploaded = true;
        });
        debugPrint("ID Selected: ${file.path}");
      }
    } catch (e) {
      debugPrint("Error picking ID: $e");
    }
  }

  void _takeSelfie() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
      );
      if (photo != null) {
        setState(() {
          _selfieFile = photo;
          isSelfieCaptured = true;
        });
        debugPrint("Selfie Captured: ${photo.path}");
      }
    } catch (e) {
      debugPrint("Error taking selfie: $e");
    }
  }

  void _submitVerification() async {
    if (_idFile == null || _selfieFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload both images')),
      );
      return;
    }
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }
    if (_ssnController.text.length != 14) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('SSN must be 14 digits')));
      return;
    }

    setState(() => isLoading = true);

    try {
      final String? token = await AuthService.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

      if (token != null) {
        request.headers['Authorization'] = 'bearer $token';
      }

      request.fields['categoryId'] = _selectedCategoryId!;
      request.fields['bio'] = _bioController.text;
      request.fields['ssn'] = _ssnController.text;

      request.files.add(
        await http.MultipartFile.fromPath(
          'id_image',
          _idFile!.path,
          contentType: MediaType('image', 'jpeg'),
          filename: 'id_image.jpg',
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'live_image',
          _selfieFile!.path,
          contentType: MediaType('image', 'jpeg'),
          filename: 'live_image.jpg',
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MainScreen(selectedSkills: widget.selectedSkills),
          ),
        );
      } else {
        if (!mounted) return;
        String errorMessage = 'Upload failed: ${response.statusCode}';
        try {
          final responseData = jsonDecode(response.body);
          if (responseData['message'] != null) {
            errorMessage = responseData['message'];
          }
        } catch (_) {}

        debugPrint("Upload failed body: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
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
    return Container(
      width: double.infinity,
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
                    Icon(
                      Icons.check_circle,
                      color: AppColors.primaryDarkGreen,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stepNumber == 1 ? 'ID Selected' : 'Selfie Captured',
                      style: TextStyle(
                        color: AppColors.primaryDarkGreen,
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
        title: const Text('Worker Verification'),
        backgroundColor: AppColors.primaryDarkGreen,
        foregroundColor: AppColors.backgroundWhite,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify your identity with AI',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 30),

            // --- SSN Field ---
            Text(
              'Social Security Number (14 digits)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _ssnController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your 14-digit SSN',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Bio Field ---
            Text(
              'Professional Bio',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Briefly describe your experience...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Category Dropdown ---
            Text(
              'Work Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 8),
            _isFetchingCategories
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                    items: _categories.map<DropdownMenuItem<String>>((dynamic cat) {
                      final String catId = cat['_id']?.toString() ?? '';
                      final String catName = cat['name']?.toString() ?? 'Unknown';
                      return DropdownMenuItem<String>(
                        value: catId.isNotEmpty ? catId : null,
                        child: Text(catName),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedCategoryId = val),
                    decoration: InputDecoration(
                      hintText: 'Select your specialty',
                      prefixIcon: const Icon(Icons.category_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
            const SizedBox(height: 30),
            _buildVerificationTile(
              stepNumber: 1,
              title: 'Upload ID',
              description: "Upload a government-issued ID.",
              buttonText: 'Gallery',
              icon: Icons.upload_file,
              isDone: isIdUploaded,
              onPressed: _uploadId,
            ),
            _buildVerificationTile(
              stepNumber: 2,
              title: 'Take a Selfie',
              description: 'Take a clear photo for face matching.',
              buttonText: 'Camera',
              icon: Icons.camera_alt_outlined,
              isDone: isSelfieCaptured,
              onPressed: _takeSelfie,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (isVerificationComplete && !isLoading)
                    ? _submitVerification
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDarkGreen,
                  foregroundColor: AppColors.secondaryLightBeige,
                  disabledBackgroundColor: AppColors.button,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isVerificationComplete
                            ? 'Submit for AI Verification'
                            : 'Complete Steps First',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
