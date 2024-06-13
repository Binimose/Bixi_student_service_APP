import 'package:flutter/material.dart';
import './gpapage.dart';
import 'package:BIXI/pages/Home.dart';

class ScorePage extends StatelessWidget {
  final double score;
  ScorePage(this.score);
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
    return new Material(
        color: Color.fromARGB(255, 0, 0, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Your GPA is: ",
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0)),
            new Text(
                score
                    .toStringAsFixed(score.truncateToDouble() == score ? 0 : 3),
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0)),
            new IconButton(
              icon: new Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 50.0,
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Home(
                      imagePath: 'assets/logo.png',
                      newsPosts: newsPost, // Provide the list of news posts
                    ),
                  ),
                  (Route route) => route == null),
            )
          ],
        ));
  }
}
