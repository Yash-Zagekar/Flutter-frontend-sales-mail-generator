import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
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
                          'Forgot Password',
                          style: TextStyle(
                              color: Color.fromARGB(255, 42, 165, 155),
                              fontFamily: "Poppins",
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
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
                        Container(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: (() {
                              reset();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "Password Link has been sent !",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                ),
                                duration: Duration(seconds: 2),
                              ));
                            }),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(62, 0, 0, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15), // Padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  // Button shape
                                ),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 138, 138, 138))),
                            child: const Text(
                              'Send Link',
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
