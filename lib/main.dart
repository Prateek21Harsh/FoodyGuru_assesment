import 'package:flutter/material.dart';
import 'package:foodyguru_temp/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FoodyGuru());
}

class FoodyGuru extends StatelessWidget {
  const FoodyGuru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foody Guru',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

