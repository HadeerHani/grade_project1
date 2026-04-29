import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'package:second_project/core/api_constants.dart';
import 'package:second_project/core/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:second_project/screens/home_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  final String serviceName;
  const JobDetailsScreen({super.key, required this.serviceName});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final _formKey = GlobalKey<FormState>(); // مفتاح الفاليديشن

  // كنترولرز الخانات
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  File? _selectedImage; // متغير لحفظ الصورة المختارة
  bool _isLoading = false;
  String? _categoryId; // To store the real ID from backend

  // ميثود اختيار الصورة من الجاليري
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // ميثود اختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // مينفعش يختار تاريخ قديم
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategoryId();
  }

  Future<void> _fetchCategoryId() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.categories));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        List<dynamic> fetchedCategories = [];

        if (decodedData is List) {
          fetchedCategories = decodedData;
        } else if (decodedData is Map<String, dynamic>) {
          if (decodedData.containsKey('data') &&
              decodedData['data'] is Map &&
              decodedData['data']['categories'] != null) {
            fetchedCategories = decodedData['data']['categories'];
          } else if (decodedData.containsKey('categories')) {
            fetchedCategories = decodedData['categories'];
          }
        }

        // Try to find the category ID that matches serviceName
        for (var cat in fetchedCategories) {
          if (cat['name'].toString().toLowerCase() ==
              widget.serviceName.toLowerCase()) {
            setState(() {
              _categoryId = cat['_id'].toString();
            });
            break;
          }
        }
        
        // If not found, use the first one as a fallback or keep it null
        if (_categoryId == null && fetchedCategories.isNotEmpty) {
          // For testing, just take the first one if name doesn't match
           // _categoryId = fetchedCategories[0]['_id'].toString();
        }
      }
    } catch (e) {
      debugPrint('Error fetching category ID: $e');
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _budgetController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitJob() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw 'Authentication token not found. Please log in again.';
      }

      final url = Uri.parse(ApiConstants.tasks);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $token',
      };

      final body = jsonEncode({
        'title': "${widget.serviceName} Service Request",
        'date': _dateController.text,
        'time': _timeController.text,
        'budget': int.tryParse(_budgetController.text) ?? 0,
        'description': _descController.text,
        'location': _locationController.text,
        'categoryId': _categoryId ?? "656f636b65745f6964313233",
      });

      debugPrint('Submitting Task: $body');

      final response = await http.post(url, headers: headers, body: body);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task posted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      } else {
        debugPrint('POST TASK FAILED: ${response.statusCode}');
        debugPrint('RESPONSE BODY: ${response.body}');
        throw responseData['message'] ?? 'Failed to post task';
      }
    } catch (e) {
      debugPrint('SUBMIT ERROR: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      appBar: AppBar(
        title: Text("${widget.serviceName} Request"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form( // تغليف الشاشة بالـ Form للفاليديشن
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("New Job Details", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryDarkGreen)),
              const SizedBox(height: 8),
              const Text("Tell us when, where, and what needs fixing. Required fields are marked.",
                  style: TextStyle(color: AppColors.textgrey, fontSize: 14)),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      "Date (Required)", 
                      "Select Date",
                      controller: _dateController,
                      suffixIcon: Icons.calendar_month,
                      onTap: () => _selectDate(context),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildInputField(
                      "Time (Required)", 
                      "e.g., 10:00 AM", 
                      controller: _timeController,
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildInputField(
                "Proposed Budget (USD - Required)", 
                "Max budget (e.g., 150)",
                controller: _budgetController,
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Enter budget' : null,
              ),
              
              const SizedBox(height: 20),
              _buildInputField(
                "Description of Job (Required)", 
                "Describe the issue in detail (e.g., Leaky pipe under the sink...)", 
                controller: _descController,
                maxLines: 4,
                validator: (val) => val!.isEmpty ? 'Description is required' : null,
              ),

              const SizedBox(height: 20),
              const Text("Photo Reference (Optional)", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryDarkGreen)),
              const SizedBox(height: 10),
              
              // زرار اختيار وعرض الصورة
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: _selectedImage == null ? 50 : 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.button,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _selectedImage == null 
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt_outlined, color: AppColors.primaryDarkGreen),
                            SizedBox(width: 10),
                            Text("Add Photo of Job Site", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDarkGreen)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity),
                        ),
                ),
              ),

              const SizedBox(height: 20),
              _buildInputField(
                "Detailed Location / Access Notes (Required)", 
                "456 Customer Ave, Apt 1A, use side gate.",
                controller: _locationController,
                validator: (val) => val!.isEmpty ? 'Location is required' : null,
              ),

              const SizedBox(height: 30),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDarkGreen,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: _isLoading ? null : _submitJob,
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.secondaryLightBeige)
                    : const Text("Post Job & Find Worker",
                        style: TextStyle(color: AppColors.secondaryLightBeige, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ميثود بناء الخانات بعد التعديل لـ TextFormField وإضافة الـ validator
  Widget _buildInputField(
    String label, 
    String hint, {
    int maxLines = 1, 
    TextEditingController? controller, 
    IconData? suffixIcon, 
    VoidCallback? onTap,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primaryDarkGreen)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly: onTap != null,
          onTap: onTap,
          keyboardType: keyboardType,
          validator: validator, // تفعيل الفاليديشن هنا
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}