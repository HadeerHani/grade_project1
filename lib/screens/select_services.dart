import 'package:second_project/screens/verefication2_screen.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
// lib/screens/select_services_screen.dart (الكود النهائي)

import 'package:flutter/material.dart';


class SelectServicesScreen extends StatefulWidget {
  const SelectServicesScreen({super.key});

  @override
  State<SelectServicesScreen> createState() => _SelectServicesScreenState();
}

class _SelectServicesScreenState extends State<SelectServicesScreen> {
  final List<String> _selectedSkills = ['Electrician', 'Appliance Repair', 'Gardening & Lawn Care', 'AC & Cooling Repair', 'Painter']; 

  final Map<String, List<String>> _serviceCategories = {
    'Home Repair & Maintenance': [
      'Electrician', 'Plumber', 'Carpenter', 'Painter', 
      'AC & Cooling Repair', 'Appliance Repair', 'Door & Lock Repair', 
      'Gardening & Lawn Care', 'Home Cleaning'
    ],
    'Cleaning & Sanitation': [
      'Pest Control', 'Office & Commercial Cleaning', 
      'Disinfection & Sanitation', 'Home Cleaning'
    ],
    'Personal & Lifestyle Services': [
      'Barber at Home', 'Beauty / Makeup Artist', 
      'Laundry & Ironing'
    ],
    'Vehicle Services': [
      'Car Wash (At Home)'
    ],
    'Moving & Logistics': [
      'Furniture Moving', 'Delivery & Courier Services'
    ],
    'Other Services': [
      'CCTV & Security Systems', 'Smart Home Setup & Repair', 
      'Swimming Pool Maintenance', 'Interior Decoration', 
      'Customized Request'
    ],
  };

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }
  Widget _buildSkillChip(String skill) {
    final isSelected = _selectedSkills.contains(skill);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: ChoiceChip(
        label: Text(skill),
        selected: isSelected,
        
        // لون خلفية الـ Chip (غير مختارة: 
        backgroundColor: AppColors.button, 
         // لون خلفية الـ Chip 
        selectedColor: AppColors.primaryDarkGreen, 
     
             
        labelStyle: TextStyle(
          color: isSelected ? AppColors.secondaryLightBeige : AppColors.primaryDarkGreen,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.primaryDarkGreen, 
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        checkmarkColor: AppColors.secondaryLightBeige, 
        
        onSelected: (bool selected) {
          _toggleSkill(skill);
        },
      ),
    );
  }

  Widget _buildServiceCategory(String title, List<String> skills) {
    return Container(
      width: double.infinity, 
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      
      decoration: BoxDecoration(
        color: AppColors.secondaryLightBeige, 
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkGreen,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              children: skills.map((skill) => _buildSkillChip(skill)).toList(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSelectedSkillsSummary() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Skills (${_selectedSkills.length})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: _selectedSkills.map((skill) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Chip(
                  label: Text(skill),
                  backgroundColor: AppColors.primaryDarkGreen,
                  labelStyle: TextStyle(color: AppColors.secondaryLightBeige, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: AppColors.primaryDarkGreen, width: 2.0),
                  ),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  deleteIconColor: AppColors.secondaryLightBeige,
                  onDeleted: () => _toggleSkill(skill),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite, 
      
      appBar: AppBar(
        title: Text('Select Services', style: TextStyle(color: AppColors.secondaryLightBeige)),
        //centerTitle: true,
        elevation: 0,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Choose skills by category',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color:AppColors.primaryDarkGreen),
              ),
            ),
            ..._serviceCategories.entries.map((entry) {
              return _buildServiceCategory(entry.key, entry.value);
            }).toList(),
            
            const SizedBox(height: 20),
            _buildSelectedSkillsSummary(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _selectedSkills.isEmpty ? null : () {
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Verification2Screen();
                  },
                ),
              );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDarkGreen,
                  foregroundColor: AppColors.backgroundWhite,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Complete Registration', style: TextStyle(fontSize: 18,)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}