import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodyguru_temp/rounded_button.dart';
import 'package:foodyguru_temp/welcome_screen.dart';
import 'text_field_decoration.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final  _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String emailReset;
  bool isVisible = false;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset('assets/foodchoice.json', width: 300, height: 300),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: TextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: TextFieldDecoration.copyWith(hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () async {

                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                  if (user != null) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return WelcomeScreen();
                        },
                      ),
                    );
                  }
                }
                catch(e){
                  print(e);
                }
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.lightBlueAccent,
              onPressed: () async {

                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                  if (newUser != null) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return WelcomeScreen();
                      },
                    ),
                    );
                  }
                }
                catch(e){
                  print(e);
                }
              },
            ),
            Divider(
              color: Colors.grey[800],
              height: 30.0,
            ),
            Visibility(
              visible: isVisible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      emailReset = value;
                    },
                    decoration: TextFieldDecoration.copyWith(hintText: 'Enter your email'),
                  ),
                  RoundedButton(
                    title: 'Reset Password',
                    colour: Colors.indigoAccent,
                    onPressed: () async {
                      await _auth.sendPasswordResetEmail(email: emailReset);
                      final snackBar = SnackBar(
                        content: const Text('Password Reset Email Sent'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () { },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}