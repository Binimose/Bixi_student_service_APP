import 'package:flutter/material.dart';
import 'dart:async';
import './gpa_calc.dart';
import 'package:BIXI/pages/Home.dart';

class GPA extends StatefulWidget {
  @override
  GPAState createState() => new GPAState();
}

class GPAState extends State<GPA> {
  TextEditingController controller = new TextEditingController();
  int n = 0;
  @override
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
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            "GPA calculator",
            style: TextStyle(color: Colors.white), // Style the text here
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0)),
      backgroundColor: Colors.orange[100],
      body: new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.transparent, width: 25.0),
            color: Colors.transparent),
        child: new ListView(
          children: <Widget>[
            new TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: new InputDecoration(
                  fillColor: const Color.fromARGB(255, 0, 0, 0),
                  hintText: "How many subjects did you have ",
                  hintStyle: new TextStyle(color: Colors.black54)),
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (String str) {
                setState(() {
                  if (controller.text == "") n = 0;
                  n = int.parse(controller.text);
                });
              },
            ),
            new IconButton(
              icon: new Icon(Icons.arrow_forward),
              onPressed: () {
                if (n is int && n > 0) {
                  int pass = n;
                  n = 0;
                  controller.text = "";
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new GPAcalc(pass)));
                } else {
                  controller.text = "";
                  alert();
                }
              },
            )
          ],
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
                builder: (context) => new Home(
                  imagePath: 'assets/logo.png',
                  newsPosts: newsPost, // Provide the list of news posts
                ),
              ),
            );
          }
          // Add other cases if needed
        },
      ),
    );
  }

  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('rewind and regret fool !'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('You think you are smart?.'),
                new Text('Guess what... you are not.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Regret'), // Adding 'const' here
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
