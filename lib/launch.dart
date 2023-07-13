// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MyHomePage extends StatelessWidget {
//   final String url = 'https://www.linkedin.com/login';

//   void _launchURL(BuildContext context) async {
//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Launching URL...'),
//         ),
//       );
//       await tryLaunch(url);
//     } else {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Could not launch URL.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('URL Launcher Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _launchURL(context),
//           child: Text('Launch URL'),
//         ),
//       ),
//     );
//   }
  
//   tryLaunch(String url) {}
// }
