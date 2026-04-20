import 'package:flutter/material.dart';
import 'package:modelhandling/screen/chat_screen.dart';
import 'package:modelhandling/screen/login_screen.dart';
import 'package:modelhandling/screen/product_screen.dart';
import 'package:modelhandling/screen/signup_screen.dart';
import 'package:modelhandling/screen/student_list_screen.dart';
import 'package:modelhandling/screen/student_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://mobrmxjaxcduivacxtfc.supabase.co', 
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vYnJteGpheGNkdWl2YWN4dGZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzExNzczMzQsImV4cCI6MjA4Njc1MzMzNH0.XQL67TCagXHJBrV7XlV4YUIWz5Fs0kcEZrExFPkN4jU');
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChatPage(username:  'Lis'),
    );
  }
}

