import 'package:flutter/material.dart';

void main() {
  runApp(const EzziGroceryApp());
}

class EzziGroceryApp extends StatelessWidget {
  const EzziGroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بقالة العزي للمواد الغذائية',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('بقالة العزي للمواد الغذائية'),
          backgroundColor: const Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
              SizedBox(height: 16),
              Text(
                'تم بناء تطبيق بقالة العزي بنجاح!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
