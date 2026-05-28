import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgot.dart';
import 'signup.dart';
import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isHiddenPassword = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    Get.snackbar(
      "Success",
      "Login Successful",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to home page
    // Replace HomePage() with your actual page
    Get.offAll(() => HomePage());

  } on FirebaseAuthException catch (e) {
    Get.snackbar(
      "Login Failed",
      e.message ?? "Unknown error",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
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
            ElevatedButton(onPressed: (()=>signIn()), child: Text("Login")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (()=>Get.to(Signup())), child: Text("Register Now")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (()=>Get.to(Forgot())), child: Text("Forgot password?")),
            SizedBox(height: 20,)
          ]
        )
      ),
    );
  }
}