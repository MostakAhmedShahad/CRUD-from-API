import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/ProductCreateScreen.dart'; // Ensure the import path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App', 
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, 
        ),
        useMaterial3: true,  
      ),
      home:   Productcreatescreen(),  
    );
  }
}