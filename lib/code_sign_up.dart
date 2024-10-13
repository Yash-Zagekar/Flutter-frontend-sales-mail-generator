import 'dart:ui';
import 'package:cold_mail_ai/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CodeSignUp extends StatefulWidget {
  const CodeSignUp({super.key});

  @override
  State<CodeSignUp> createState() => _CodeSignUpState();
}

class _CodeSignUpState extends State<CodeSignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;

  signup() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);

      Get.offAll(const Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Invalid email format", e.code);
    } catch (e) {
      Get.snackbar("Please ensure your email format", e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blurred Glass Effect
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10.0, sigmaY: 10.0), // Adjust blur amount
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.3), // Semi-transparent white
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: 300, // Set width for the login form
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Signup',
                          style: TextStyle(
                              color: Color.fromARGB(255, 42, 165, 155),
                              fontFamily: "Poppins",
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/welcome.gif"),
                          )),
                        ),
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                fontFamily: "Poppins", color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(117, 255, 255, 255),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white), // White border
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0), // White border when focused
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontFamily: "Poppins", color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(123, 255, 255, 255),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white), // White border
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0), // White border when focused
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromARGB(255, 255, 255, 255)),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: (() {
                              signup();
                            }),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(111, 0, 0, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15), // Padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  // Button shape
                                ),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 138, 138, 138))),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),

                        // not a member? register now
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
