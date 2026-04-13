import 'package:flutter/material.dart';
import 'package:prelim_exam/calculator-1.dart';


void main() {
  runApp(const CalculatorScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CalculatorScreen(),
    );
  }
}

