import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signup()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "Enter Email"),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: "Enter Password"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (()=>signup()), child: Text("Sign Up"))
          ]
        )
      ),
    );
  }
}