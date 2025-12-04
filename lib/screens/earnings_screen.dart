// lib/screens/earnings_screen.dart

import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

import 'jobs_screen.dart'; // لاستخدام AppCard

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});
  
  // AppBar خاص بصفحة الأرباح
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
      backgroundColor: AppColors.backgroundWhite,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Earnings History',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDarkGreen),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'You\'ve earned a total of \$280',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700),
              ),
            ),
            _buildEarningsItem(
              task: 'Unclog main shower drain',
              customer: 'Jane D.',
              amount: 120,
              date: 'Sep 28, 2025',
              rating: 4.0,
              icon: Icons.water_drop_outlined,
            ),
            _buildEarningsItem(
              task: 'Install new ceiling fan',
              customer: 'Tom H.',
              amount: 160,
              date: 'Oct 1, 2025',
              rating: 5.0,
              icon: Icons.bolt,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsItem({
    required String task,
    required String customer,
    required int amount,
    required String date,
    required double rating,
    required IconData icon,
  }) {
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.button, size: 30),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.primaryDarkGreen),
                  ),
                  Text('Customer: $customer',
                      style: const TextStyle(fontSize: 14, color: const Color.fromRGBO(117, 117, 117, 1))),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(date,
                          style: const TextStyle(
                              fontSize: 12, color:AppColors.primaryDarkGreen)),
                      const SizedBox(width: 8),
                      Icon(Icons.star, color: AppColors.primaryDarkGreen, size: 12),
                      Text(rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12,color: AppColors.primaryDarkGreen)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text('+\$$amount',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen)),
        ],
      ),
    );
  }
}