import 'package:flutter/material.dart';

class MetallicBox extends StatelessWidget {
  const MetallicBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Metallic Box UI',
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Metallic gradient box with two boxes in a row
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade400,
                    Colors.grey.shade600,
                    Colors.grey.shade800,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // First box
                  Column(
                    children: const [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Generate Email',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Create professional emails',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  // Second box
                  Column(
                    children: const [
                      Icon(
                        Icons.model_training,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'AI Model',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Train AI models easily',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // TextField with upward arrow icon
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      hintText: "Enter a Job Link",
                      hintStyle: const TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white70,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade400,
                        Colors.grey.shade600,
                        Colors.grey.shade800,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_upward, color: Colors.white),
                    onPressed: () {
                      // Define your action here
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
