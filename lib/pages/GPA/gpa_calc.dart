import 'package:flutter/material.dart';
import './score_page.dart';
import 'dart:async';

class GPAcalc extends StatefulWidget {
  final int n;

  GPAcalc(this.n);

  @override
  GPAcalcstate createState() => new GPAcalcstate();
}

class GPAcalcstate extends State<GPAcalc> {
  List<String> _items = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'D',
    'F'
  ];
  List<String> _itemsCp = ['1', '2', '3', '4', '', '6'];
  var _selection;
  var _selectionCp;
  var list;

  @override
  void initState() {
    super.initState();
    _selection = List<String>.filled(widget.n, _items.first);
    _selectionCp = List<String>.filled(widget.n, _itemsCp.first);
    list = List<int>.generate(widget.n, (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    int sogxc = 0, soc = 0;
    var textFields = <Widget>[];
    bool safeToNavigate = true;
    textFields.add(
      new Row(children: [
        new Padding(
          padding: new EdgeInsets.only(left: 96.0),
        ),
        new Column(children: [
          new Text(
            "Grade",
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ]),
        new Padding(
          padding: new EdgeInsets.only(left: 72.0),
        ),
        new Column(
          children: [
            new Text(
              "Credits",
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ],
        ),
        new Padding(
          padding: new EdgeInsets.only(bottom: 25.0),
        ),
      ]),
    );
    list.forEach((i) {
      textFields.add(
        new Column(
          children: [
            new Row(
              children: [
                new Text(
                  "Subject ${i + 1}:",
                  style: new TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: new EdgeInsets.all(10.0),
                ),
                new DropdownButton<String>(
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  hint: new Text(
                    "grade ${i + 1}",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.normal),
                  ),
                  value: _selection[i],
                  items: _items.map((String item) {
                    return new DropdownMenuItem<String>(
                      value: item,
                      child: new Text(
                        item,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (s) {
                    setState(() {
                      _selection[i] = s;
                    });
                  },
                ),
                new Padding(
                  padding: new EdgeInsets.all(35.0),
                ),
                new DropdownButton<String>(
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  hint: new Text(
                    "credit ${i + 1}",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.normal),
                  ),
                  value: _selectionCp[i],
                  items: _itemsCp.map((String items) {
                    return new DropdownMenuItem<String>(
                      value: items,
                      child: new Text(
                        items,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (s) {
                    setState(() {
                      _selectionCp[i] = s;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });

    double res = 0.0;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "GPA calculator",
          style: TextStyle(color: Colors.white), // Style the text here
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Colors.orange[100],
      body: new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.transparent, width: 30.0)),
        child: new ListView(
          children: textFields,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Calculate',
        backgroundColor: Colors.deepOrangeAccent,
        child: new Icon(Icons.gavel),
        onPressed: () {
          for (int i = 0; i < widget.n; i++) {
            if (_selectionCp[i] == null) {
              safeToNavigate = false;
              continue;
            }
            if (_selection[i] == null) {
              safeToNavigate = false;
              continue;
            }
            int r = int.parse(_selectionCp[i]);
            double gp = calculate(_selection[i]);
            int cp = r;
            double gxc = gp * cp;
            sogxc += gxc.toInt();

            soc += cp;
          }
          res = sogxc / soc;
          if (safeToNavigate)
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new ScorePage(res),
              ),
            );
          else {
            alert();
          }
        },
      ),
    );
  }

  double calculate(String a) {
    switch (a) {
      case 'A+':
        return 4.0;
      case 'A':
        return 4.0;
      case 'A-':
        return 3.75;
      case 'B+':
        return 3.5;
      case 'B':
        return 3.25;
      case 'B-':
        return 3.0;
      case 'C+':
        return 2.75;
      case 'C':
        return 2.5;
      case 'C-':
        return 2.25;
      case 'D':
        return 2.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }

  Future<Null> alert() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Rewind and remember'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('You have done something terrible.'),
                new Text('Go back and reflect on your mistakes.'),
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
