// lib/screens/jobs_screen.dart

import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';
class AppCard extends StatelessWidget {
  final Widget child;
  const AppCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundWhite,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

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
        IconButton(
          icon: const Icon(Icons.person_rounded),
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
                'Available Jobs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ), 
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Showing tasks matching your Electrician, Appliance Repair, Painter specialty.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ), 
              ),
            ),
            _buildJobCard(
              title: 'Outdoor Circuit Breaker',
              specialty: 'Electrician',
              price: 250,
              details: 'Need a dedicated 20A circuit run to the new shed.',
              location: 'East Suburbs, 15 mi',
              posted: 'Posted 3h ago',
              icon: Icons.lightbulb_outline,
            ),
            _buildJobCard(
              title: 'Unusual Request',
              specialty: 'Customized Request',
              price: 100,
              details:
                  'Need someone to assemble complex Swedish flat-pack furniture.',
              location: 'North City, 5 mi',
              posted: 'Posted 2h ago',
              icon: Icons.auto_fix_high,
            ),
            const SizedBox(height: 10),
            _buildRatingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard({
    required String title,
    required String specialty,
    required int price,
    required String details,
    required String location,
    required String posted,
    required IconData icon,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(icon, color: AppColors.button, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDarkGreen,
                        ),
                      ),
                    ), 
                  ],
                ),
              ),
              Text(
                '\$$price',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDarkGreen,
                ),
              ), 
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primaryDarkGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
            ),
            child: Text(
              specialty,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primaryDarkGreen, 
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            details,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ), 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '$location | $posted',
                  style: TextStyle(fontSize: 12, color: const Color.fromRGBO(117, 117, 117, 1)),
                ), 
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:
                 AppColors.button,foregroundColor: AppColors.primaryDarkGreen),
                onPressed: () {},
                child: const Text('View Details & Act'), 
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Latest Ratings (2)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDarkGreen,
            ),
          ),
          const Divider(height: 20,color: AppColors.primaryDarkGreen),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.button, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Customer Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDarkGreen,
                        ),
                      ), 
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'You received 2 ratings.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ), 
              const Divider(height: 20,color: AppColors.primaryDarkGreen,),
              _buildRatingItem('4.0 from Jane D.', 'Sep 28, 2025'),
              _buildRatingItem('5.0 from Mark R.', 'Oct 1, 2025'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingItem(String rating, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rating,
            style: TextStyle(fontSize: 14, color: AppColors.primaryDarkGreen),
          ), 
          Text(
            date,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ), 
        ],
      ),
    );
  }
}
