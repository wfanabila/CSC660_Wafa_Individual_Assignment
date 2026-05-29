import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgot.dart';
import 'signup.dart';
import 'homepage.dart';
import 'Animation/FadeAnimation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHiddenPassword = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signInWithEmail() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 6, 97, 255),
              Color.fromARGB(255, 156, 191, 255),
              Color.fromARGB(255, 6, 97, 255),
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  FadeAnimation(1, Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                  SizedBox(height: 10),
                  FadeAnimation(1.3, Text(
                    "Welcome back! Please login to your account.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )),
                ]
              )
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget> [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color(0xFF0052DD).withOpacity(0.2),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )]
                          ),
                          child: Column(
                            children: <Widget> [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey)),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey)),
                                      ),
                                      child: TextField(
                                        controller: password,
                                        obscureText: isHiddenPassword,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
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
                                      ), //password textfield
                                    ),//container
                                  ], //children widget
                                ), //column
                              ), //container
                            ] //children widget
                          ) //column
                        ), //container
                        SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                          onPressed: () {
                            Get.to(() => const Forgot());
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF0052DD),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          color: Color(0xFF0052DD),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          )]
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                      ),
                      SizedBox(height: 20),

                      Align(
                          alignment: Alignment.center,
                          child: TextButton(
                          onPressed: () {
                            Get.to(() => const Signup());
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF0052DD),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "Doesn't have an account? Sign up now!",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),


                      ], //children widget
                    ),
                  )
              ) //container
            ) //expanded
          ], //children widget
        )
      )
    );
  }
}