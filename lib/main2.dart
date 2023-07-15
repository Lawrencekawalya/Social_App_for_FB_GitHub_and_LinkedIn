import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

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
      home: const MyFirstPage(),
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
              "Students of BSU",
              style: TextStyle(
                color: Color.fromARGB(255, 37, 227, 16),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Rest of your code
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
      ),
    );
  }
}
