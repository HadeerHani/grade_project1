// lib/screens/account_screen.dart

import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
import 'jobs_screen.dart'; // لاستخدام AppCard

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  PreferredSizeWidget _buildAppBar(BuildContext context) {
      return AppBar(
        automaticallyImplyLeading: false,
      title: Text(
        'FIXPAY',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: AppColors.backgroundWhite,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLightBeige,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'My Account',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen),
            ),
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildPersonalInformation(),
            const SizedBox(height: 20),
            _buildWorkerStatus(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redDotBorder, 
                foregroundColor: AppColors.secondaryLightBeige,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Log Out', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.primaryDarkGreen,
          child: const Text('SN',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen)),
        ),
        const SizedBox(height: 8),
        const Text('Spencer N.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryDarkGreen)),
        const Text('Verified Professional',
            style: TextStyle(fontSize: 14, color: AppColors.textgrey)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDarkGreen),
      ),
    );
  }

  Widget _buildInformationRow(String label, String value, {bool isSecret = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:',
                style: const TextStyle(fontSize: 14, color:AppColors.primaryDarkGreen)),
          ),
          Expanded(
            child: Text(
              isSecret ? '--*5678' : value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInformation() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Personal Information'),
          _buildInformationRow('NAME', 'Spencer N.'),
          _buildInformationRow('EMAIL', 'spencer.n@email.com'),
          _buildInformationRow('PHONE', '+1 (555) 123-4567'),
          _buildInformationRow('ADDRESS', '123 Worker Lane, City, State'),
          _buildInformationRow('SSN', '--*5678', isSecret: true),
          const SizedBox(height: 10),
          _buildSectionTitle('BIO'),
          const Text(
              'Certified Electrician with 5+ years of expertise in home wiring and electrical.',
              style: TextStyle(fontSize: 14,color:  const Color.fromRGBO(117, 117, 117, 1))),
        ],
      ),
    );
  }

  Widget _buildWorkerStatus() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Worker Status'),
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.primaryDarkGreen, size: 20),
              const SizedBox(width: 8),
              const Text('Verification: Verified',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.primaryDarkGreen)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Specialties: (3)', style: TextStyle(fontSize: 14,color:  const Color.fromRGBO(117, 117, 117, 1))),
              TextButton(
                  onPressed: () {},
                  child: const Text('Update Services',
                      style: TextStyle(color: const Color.fromRGBO(117, 117, 117, 1)))),
            ],
          ),
        ],
      ),
    );
  }
}