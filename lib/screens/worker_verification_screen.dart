import 'package:flutter/material.dart';
import 'package:second_project/screens/welcome_screen_modified.dart';

class WorkerVerificationScreen extends  StatefulWidget {
  const WorkerVerificationScreen ({super.key});

  @override
  State<WorkerVerificationScreen > createState() => _WorkerVerificationScreen ();
}

class _WorkerVerificationScreen  extends State<WorkerVerificationScreen > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title:const Text('Worker Verification') ),
    );
  }
}