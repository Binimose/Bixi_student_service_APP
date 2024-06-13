import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:BIXI/pages/Home.dart';
import 'package:BIXI/pages/Splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "assets/.env");
    print("Environment variables loaded: ${dotenv.env}");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      initialRoute: '/splash', // Corrected initial route name
      routes: {
        '/splash': (context) => Splash(), // Define splash screen route
        '/home': (context) => Home(
              imagePath: 'assets/logo.png',
              newsPosts: newsPost, // Provide the list of news posts
            ),
      },
    );
  }
}
