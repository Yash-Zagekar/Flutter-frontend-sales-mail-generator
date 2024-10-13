import 'package:cold_mail_ai/Test.dart';
import 'package:cold_mail_ai/editor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? displayName;
  String? photoUrl;
  String? email;

  @override
  void initState() {
    super.initState();
    getDisplayName();
  }

  void getDisplayName() {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        displayName = user.displayName ?? 'Guest';
        photoUrl = user.photoURL;
        email = user.email;
      });
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  googlesingnout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              displayName ?? "Guest",
              style: const TextStyle(color: Colors.white, fontFamily: "nice"),
            ),
            accountEmail: Text(
              email ?? "No Email Available",
              style: const TextStyle(
                  color: Color.fromARGB(255, 150, 150, 150),
                  fontFamily: "nice"),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30, // Adjust the size as needed
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl!)
                  : null, // If the photo URL is null, don't show an image
              child: photoUrl == null
                  ? Icon(Icons.person, size: 25) // Placeholder icon
                  : null,
            ),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 41, 41, 41)),
          ),
          ListTile(
              leading: const Icon(
                Icons.mail_outline_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Generate Buiness Mail",
                style: TextStyle(
                    fontFamily: "nice", color: Colors.white, fontSize: 15),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MainGeneration()), // Navigate to a new page
                );
              }),
          ListTile(
            leading: const Icon(
              Icons.edit,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            title: const Text(
              "Editor",
              style: TextStyle(
                  fontFamily: "nice", color: Colors.white, fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TextEditorScreen()), // Navigate to a new page
              );
            },
          ),
          const SizedBox(
            height: 400,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: Color.fromARGB(255, 185, 0, 0),
            ),
            title: const Text(
              "logout",
              style: TextStyle(
                  fontFamily: "nice", color: Colors.white, fontSize: 14),
            ),
            onTap: () {
              signout();
              googlesingnout();
            },
          ),
        ],
      ),
    );
  }
}
