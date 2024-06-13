import 'package:flutter/material.dart';
import 'package:BIXI/pages/ChooseLocation.dart';
import 'package:BIXI/pages/Loading.dart';
import './GPA/gpapage.dart';
import 'package:BIXI/screens/home/home.dart';

class Home extends StatelessWidget {
  final String imagePath;
  final List<NewsPost> newsPosts;

  const Home({
    Key? key,
    required this.imagePath,
    required this.newsPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 20,
                  backgroundColor: Colors.black87,
                ),
              ],
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                // Handle onPressed event for the IconButton
              },
            ),
          ],
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true, // Makes the scrollbar thumb always visible
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black, // Set background color to black
            padding: EdgeInsets.symmetric(horizontal: 0), // Remove padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Welcome to Bixi',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Select Your Category',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 253, 253, 253),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BoxWidget(
                            text: 'GPA Calculator',
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 66, 68, 130),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GPA(),
                                ),
                              );
                            },
                          ),
                          BoxWidget(
                            text: 'News',
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(179, 232, 195, 82),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => home(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BoxWidget(
                            text: 'Market',
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(134, 123, 64, 0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loading(),
                                ),
                              );
                            },
                          ),
                          BoxWidget(
                            text: 'Scholarship',
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(130, 3, 214, 251),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseLocation(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var newsPost in newsPosts)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NewsItem(
                            newsPost: newsPost,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GPA(),
              ),
            );
          }
          // Add other cases if needed
        },
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final String text;
  final double width;
  final BoxDecoration decoration;
  final VoidCallback onPressed;

  const BoxWidget({
    Key? key,
    required this.text,
    required this.width,
    required this.decoration,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 100, // Adjust the height as needed
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10), // Adjust padding to position the text
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w900,
                fontFamily: 'Roboto-BlackItalic',
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final NewsPost newsPost;

  const NewsItem({required this.newsPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          newsPost.title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        Container(
          width: 200,
          height: 200, // Adjust as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(newsPost.imageUrl ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                newsPost.description,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsPost {
  final String title;
  final String description;
  final String? imageUrl;

  NewsPost({
    required this.title,
    required this.description,
    this.imageUrl,
  });
}
