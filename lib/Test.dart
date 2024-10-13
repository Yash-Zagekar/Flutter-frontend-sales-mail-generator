import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cold_mail_ai/models.dart';
import 'package:cold_mail_ai/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/link.dart';

import 'api_service.dart';

class MainGeneration extends StatefulWidget {
  const MainGeneration({super.key});

  @override
  State<MainGeneration> createState() => MainGenerationState();
}

class MainGenerationState extends State<MainGeneration> {
  final List<String> models = [
    'Llama 3.1 70B',
    'GPT 4',
  ];
  String? displayName;

  final TextEditingController _urlController = TextEditingController();

  void _showGlassBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(
              0, 65, 65, 65), // Make background transparent
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glass effect
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: 300,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.1), // White with transparency
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Information',
                              style: TextStyle(
                                  fontFamily: "nice",
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'The Business Mail Generator creates professional emails for various purposes, enhancing communication efficiency and fostering effective business relationships\n\nCheckout source code',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "nice"),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Link(
                                  uri: Uri.parse(
                                      "https://github.com/Yash-Zagekar/cold_mail_generator-Backend"),
                                  builder: (context, FollowLink) =>
                                      ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            0, 158, 158, 158),
                                        side: const BorderSide(
                                            color: Colors.blue)),
                                    onPressed: FollowLink,
                                    child: const Text(
                                      "Github repo",
                                      style: TextStyle(
                                          fontFamily: "nice",
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(
                                        color: Color.fromARGB(255, 216, 0,
                                            0), // Change this to your desired border color
                                        width:
                                            1, // Change this to set the desired border width
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 187, 0, 0),
                                        fontFamily: "nice"),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, String>> _chat = []; // To store chat history (message/reply)
  bool _isLoading = false;

  final apiService = ApiService(
      'https://business-mail-generator.onrender.com'); // Change URL if needed

  // Function to handle email generation
  Future<void> generateEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userUrl = _urlController.text;

      // Add user-pasted URL as a message
      setState(() {
        _chat.add({'type': 'user', 'message': userUrl});
      });

      // Call API to generate email based on the user's URL
      final emails = await apiService.generateEmail(userUrl);

      // Add generated email as a reply to the user's message
      setState(() {
        emails.forEach((email) {
          _chat.add({'type': 'reply', 'message': email});
        });
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void initState() {
    super.initState();
    getDisplayName();
  }

  void getDisplayName() {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        // Fetch the displayName, if available, otherwise fallback to 'Guest'
        displayName = user.displayName ?? 'Guest';
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color.fromARGB(255, 37, 37, 37),
          title: const Text(
            "Developer's Message",
            style: TextStyle(
                color: Colors.white, fontFamily: "nice", fontSize: 16),
          ),
          content: const Text(
            "GPT 4's support will be avaliable soon",
            style: TextStyle(
                color: Color.fromARGB(255, 7, 223, 194), fontFamily: "nice"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              ),
            ),
          ],
        );
      },
    );
  }

  String selectedModel = 'Llama 3.1 70B';
  void _selectModel(String? model) {
    if (model == 'GPT 4') {
      _showDialog(); // Show dialog for GPT 4
    } else if (model != null) {
      setState(() {
        selectedModel = model; // Update the selected model
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 27, 27),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          const SizedBox(width: 35),
          // This is an empty container to center the dropdown
          const Spacer(), // Takes up available space on the left
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 32, 32),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: const Color.fromARGB(255, 99, 99, 99))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedModel,
                    borderRadius: BorderRadius.circular(15),

                    dropdownColor: const Color.fromARGB(
                        255, 54, 54, 54), // Dropdown background color
                    // Dropdown icon
                    style: const TextStyle(
                        color:
                            Color.fromARGB(255, 150, 150, 150)), // Text style
                    onChanged: _selectModel, // Method to handle selection
                    items: models.map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Row(
                          children: [
                            Text(
                              model,

                              style: const TextStyle(
                                  color: Color.fromARGB(255, 199, 199, 199),
                                  fontFamily:
                                      "poppins"), // White text color for dropdown items
                            ),
                            const SizedBox(width: 4),
                            const Image(
                              image: AssetImage("assets/spark.gif"),
                              width: 25,
                              height: 25,
                            )
                          ],
                        ), // Text displayed for each item
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(), // Takes up available space on the right
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                _showGlassBox(context);
              },
              child: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: NavBar(),
      body: Column(
        children: [
          Expanded(
            child: _urlController.text.isEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getGreeting(),
                                  style: const TextStyle(
                                      fontFamily: "nice",
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 187, 187, 187)),
                                ),
                                const SizedBox(width: 3),
                                AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(displayName ?? "Guest",
                                        textStyle: const TextStyle(
                                            fontFamily: "nice",
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        colors: const [
                                          Color.fromARGB(255, 41, 123, 246),
                                          Color(0xFF7B1FA2), // Vibrant purple
                                          Color(0xFF29B6F6), // Purple
                                        ],
                                        speed:
                                            const Duration(milliseconds: 600)),
                                  ],
                                  totalRepeatCount: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 170),
                          Container(
                            child: Image.asset(
                              "assets/profile_image.png",
                              height: 100,
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                              height: 240), // Space above the TextField
                        ],
                      ),
                    ),
                  )
                : _isLoading
                    ? Center(
                        child: Column(
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/loading.gif"))))),
                            Text(
                              "Generating mail... \n[Might take 20 - 25 sec to generate] \nAs backend is deployed on free hosting site",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "new"),
                            ),
                          ],
                        ),
                      )
                    : _chat.isNotEmpty // Display only if there are emails
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display chat-like messages and replies
                                  if (_chat.isNotEmpty)
                                    Column(
                                      children: _chat.map((entry) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Align(
                                            alignment: entry['type'] == 'user'
                                                ? Alignment
                                                    .centerRight // Align user messages to the right
                                                : Alignment
                                                    .centerLeft, // Align replies to the left
                                            child: Stack(
                                              alignment: Alignment
                                                  .topRight, // Align icon to the top right
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: entry['type'] ==
                                                            'user'
                                                        ? Colors.blue[
                                                            700] // Different color for user messages
                                                        : Colors.grey[
                                                            800], // Different color for model replies
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Text(
                                                    entry['message'] ?? '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'new',
                                                    ),
                                                  ),
                                                ),
                                                // Copy icon button at the top right
                                                if (entry['type'] !=
                                                    'user') // Only show copy icon for replies
                                                  IconButton(
                                                    icon: const Icon(Icons.copy,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      // Copy message to clipboard
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: entry[
                                                                      'message'] ??
                                                                  ''));
                                                      // Show a SnackBar or some feedback (optional)
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'Email copied to clipboard!')),
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                  // Loading indicator while emails are being generated
                                  if (_isLoading)
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Bad response, check the URL, Paste correct URL",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "new"),
                            ),
                          ),
          ),
          // The TextField will always be at the bottom of the screen
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    controller: _urlController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 70, 70, 70),
                      hintText: '   Paste job description link.....',
                      hintStyle: const TextStyle(
                        fontFamily: 'new',
                        color: Color.fromARGB(179, 199, 199, 199),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none, // Remove the border
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'new',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    generateEmail();

                    // Ensure you're calling the email generation function here
                  },
                  child: const Icon(
                    Icons.arrow_upward_outlined,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
