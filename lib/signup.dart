import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isHiddenPassword = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signup() async {
  try {

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully"),
      ),
    );

  } on FirebaseAuthException catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? "Signup failed"),
      ),
    );

    print(e.code);
    print(e.message);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up"),),
      backgroundColor: const Color(0xFFECF1FA),
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
              obscureText: isHiddenPassword,
              decoration: InputDecoration(
              hintText: "Enter Password",
                
              suffixIcon: IconButton(
                icon: Icon(
                  isHiddenPassword 
                  ? Icons.visibility 
                  : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isHiddenPassword = !isHiddenPassword;
                  });
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (()=>signup()), child: Text("Sign Up"))
          ]
        )
      ),
    );
  }
}