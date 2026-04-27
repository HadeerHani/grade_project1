import 'package:flutter/material.dart';

class ColorScreen extends  StatelessWidget {
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x000000ff),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCF8F2)
      ),
    );
  }
} 