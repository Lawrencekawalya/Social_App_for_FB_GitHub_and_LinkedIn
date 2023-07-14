import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'image_picker.dart'; // Import the file
import 'package:url_launcher/link.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internship App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // useMaterial3: true,
      ),
      home: const MyFirstPage(),
    );
  }
}

class MyFirstPage extends StatelessWidget {
  const MyFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Internship APP",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 20.0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {
                if (kDebugMode) {
                  print("more ifo");
                }
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            // GestureDetector(
            //   onTap: _pickImage,
            //   child: CircleAvatar(
            //     backgroundImage: _image != null ? FileImage(_image!) : null,
            //     radius: 80.0,
            //   ),
            // ),

            const CircleAvatar(
              backgroundImage: AssetImage("img3.jpg"),
              radius: 80.0,
              // child: Text("BSU"),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Lawrence Kawalya",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            const Text(
              "Students of BSU",
              style: TextStyle(
                color: Color.fromARGB(255, 37, 227, 16),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Link(
                        target: LinkTarget.self,
                        uri: Uri.parse('https://www.facebook.com/'),
                        builder: (context, followLink) => ElevatedButton(
                          // onHover: ,
                          onPressed: followLink,
                          child: const Text(
                            "Facebook",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Center(
                      child: Link(
                        target: LinkTarget.self,
                        uri: Uri.parse('https://github.com/'),
                        builder: (context, followLink) => ElevatedButton(
                          onPressed: followLink,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                          ),
                          child: const Text(
                            "GitHub",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Center(
                      child: Link(
                        target: LinkTarget.self,
                        uri: Uri.parse('https://www.linkedin.com/login/'),
                        builder: (context, followLink) => ElevatedButton(
                          onPressed: followLink,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 39, 0, 100),
                            ),
                          ),
                          child: const Text(
                            "Linked In",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.collections_bookmark),
            label: 'Academics',
          ),
          NavigationDestination(
            icon: Icon(Icons.lock_person),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (int index) {},
      ),
    );
  }
}
