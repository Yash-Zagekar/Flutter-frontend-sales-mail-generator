import 'package:cold_mail_ai/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextEditorScreen extends StatefulWidget {
  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  TextEditingController _textController = TextEditingController();

  // Function to copy the mail text
  void _copyMail() {
    Clipboard.setData(ClipboardData(text: _textController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Mail copied to clipboard',
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
    );
  }

  // Function to clear the mail text
  void _clearMail() {
    setState(() {
      _textController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Mail cleared',
            style: TextStyle(fontFamily: "Poppins"),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 59, 59, 59),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Mail editor",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 209, 209, 209),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: NavBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 54, 54, 54),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "Poppins"),
                  decoration: const InputDecoration(
                    hintText: "Paste your mail here...",
                    hintStyle:
                        TextStyle(color: Colors.white54, fontFamily: "Poppins"),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _copyMail();
                    },
                    child: const Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      _clearMail();
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
