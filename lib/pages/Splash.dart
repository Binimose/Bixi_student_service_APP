import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BIXI/pages/Home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:BIXI/common/common.dart';
import 'package:BIXI/common/widgets/no_connectivity.dart';
import 'package:BIXI/screens/home/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Simulate a long initialization process before navigating to the home screen
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the home screen
      List<NewsPost> newsPost = [
        NewsPost(
          title: 'ART Night',
          description: 'Adama Ras Hotel',
          imageUrl:
              'https://lirp.cdn-website.com/fc61f1c2/dms3rep/multi/opt/Ideal+outdoor+movie+night-1920w.png',
        ),
        NewsPost(
          title: 'ART Night',
          description: 'Adama Ras Hotel',
          imageUrl:
              'https://lirp.cdn-website.com/fc61f1c2/dms3rep/multi/opt/Ideal+outdoor+movie+night-1920w.png',
        ),
        // Add more news posts as needed
      ];
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(
            imagePath: 'assets/images/logo.png',
            newsPosts: newsPost,
          ),
        ),
      );
    });
  }

  Future<void> checkConnectivity() async {
    if (await getInternetStatus()) {
      Timer(const Duration(seconds: 2), () {
        // Navigate to the home screen after 2 seconds
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const home(),
          ),
        );
      });
    } else {
      Navigator.of(context, rootNavigator: true)
          .push(
            MaterialPageRoute(
              builder: (context) => const NoConnectivity(),
            ),
          )
          .then(
            (value) => checkConnectivity(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color.fromARGB(0, 0, 0, 0),
      statusBarIconBrightness: Brightness
          .dark, // Change this to Brightness.light if your splash screen has a light background
    ));

    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 0, 0, 0), // Set your splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace this with the path to your logo image
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            Text(
              "Copyright \u00a9 2024",
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 238, 236, 236),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
