import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart'; // تأكدي من مسار الألوان

class TaskDetailsScreen extends StatefulWidget {
  final String title;
  final int price;
  final String specialty;
  final String details;

  const TaskDetailsScreen({
    super.key,
    required this.title,
    required this.price,
    required this.specialty,
    required this.details,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late int currentPrice;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    currentPrice = widget.price;
    _dateController = TextEditingController(text: "11 / 05 / 2025");
    _timeController = TextEditingController(text: "10 : 00 AM");
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryDarkGreen,
              onPrimary: Colors.white,
              onSurface: AppColors.primaryDarkGreen,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(
        () => _dateController.text =
            "${picked.day} / ${picked.month} / ${picked.year}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF2EFE9),
        currentIndex: 10, // عشان يفضل منور عند Jobs
        selectedItemColor:Colors.grey,
        // AppColors.primaryDarkGreen, // اللون الأخضر اللي إنتي مستخدماه
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        onTap: (index) {
          //if (index != 0) {
            Navigator.pop(context); // لو داس على حاجة تانية يرجعه للرئيسية
         // }
        },
      ),*/

      backgroundColor: AppColors.backgroundWhite,
      // const Color(0xFFF1F1E6),
      appBar: AppBar(title: const Text('Task Details',//style: TextStyle(color: AppColors.backgroundWhite),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTaskDetailsCard(),
            const SizedBox(height: 20),
            _buildCustomerInfoCard(),
            const SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  // الكارت الأول: تعديل ترتيب العنوان والتخصص والسعر
  Widget _buildTaskDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF2EFE9),
        //AppColors.backgroundWhite,
        // color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF2EFE9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.specialty,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$currentPrice',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryDarkGreen,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Pending Acceptance',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.backgroundWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 30, color: Colors.grey),
          const Text(
            'Job Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(widget.details, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 25),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location & Timing',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.red,
                        ),
                        Text(
                          ' East Suburbs, 15 mi',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: Colors.blue,
                        ),
                        Text(
                          ' Tomorrow, 10:00 AM',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        Text(
                          ' Posted 3h ago',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _buildSmallActionBtn(
                    'Propose Reschedule',
                    _showRescheduleDialog,
                  ),
                  const SizedBox(height: 8),
                  _buildSmallActionBtn(
                    'Propose Counter-Offer',
                    _showCounterOfferDialog,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF2EFE9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer Information',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFDDE3D5),
                child: Text(
                  'SK',
                  style: TextStyle(
                    color: AppColors.primaryDarkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah K.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        Text(
                          ' 4.8 Rating',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDarkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Message',
                  style: TextStyle(
                    color: AppColors.backgroundWhite,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 18,
                color: AppColors.primaryDarkGreen,
              ),
              SizedBox(width: 8),
              Text('+1 (555) 777-8888', style: TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  void _showCounterOfferDialog() {
    TextEditingController priceController = TextEditingController(
      text: currentPrice.toString(),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Text(
          'Propose New Price',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryDarkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: '\$ ',
            filled: true,
            fillColor: const Color(0xFFF1F1E6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () => currentPrice =
                          int.tryParse(priceController.text) ?? currentPrice,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRescheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Propose New Time',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 20),
            _buildDialogField(
              'New Date',
              _dateController,
              Icons.calendar_today,
              true,
            ),
            const SizedBox(height: 15),
            _buildDialogField(
              'New Time',
              _timeController,
              Icons.access_time,
              false,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel',style:TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkGreen,
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
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

  Widget _buildDialogField(
    String label,
    TextEditingController controller,
    IconData icon,
    bool isDate,
  ) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: isDate ? () => _selectDate(context) : null,
        ),
        filled: true,
        fillColor: const Color(0xFFF1F1E6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSmallActionBtn(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 135,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.button,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDarkGreen,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarkGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Accept (\$$currentPrice)',
              style: const TextStyle(
                color: AppColors.backgroundWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Decline Job',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
