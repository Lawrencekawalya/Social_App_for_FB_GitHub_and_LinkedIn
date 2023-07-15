import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:url_launcher/link.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internship App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyFirstPage(),
        '/academics': (context) => const AcademicsPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

class MyFirstPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MyFirstPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFirstPageState createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final appDir = await getApplicationDocumentsDirectory();
      const imageName = 'profile_image.jpg';
      final imagePath = '${appDir.path}/$imageName';
      await imageFile.copy(imagePath);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', imagePath);

      setState(() {
        _image = imageFile;
      });
    }
  }

  // ignore: unused_element
  Future<void> _removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('imagePath');

    setState(() {
      _image = null;
    });
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

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
                  print("more info");
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
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundImage: _image != null ? FileImage(_image!) : null,
                radius: 80.0,
              ),
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
              "Student of BSU",
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
                        uri: Uri.parse('https://www.linkedin.com/login/'),
                        builder: (context, followLink) => ElevatedButton(
                          onPressed: followLink,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 39, 0, 100),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(FontAwesomeIcons.linkedin),
                              SizedBox(width: 5.0),
                              Text(
                                "Linked In",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
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
      bottomNavigationBar: const NavigationBar(),
    );
  }
}

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Academics'),
        ),
        body: const Center(
          child: Text('Academics Page'),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: 'Academics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock_person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/academics');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/profile');
        }
      },
    );
  }
}
