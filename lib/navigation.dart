import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class detailedpage extends StatefulWidget {
  final String title;

  final String subtitle;

  detailedpage({this.title, this.subtitle});

  @override
  _detailedpageState createState() => _detailedpageState();
}

class _detailedpageState extends State<detailedpage> {
  @override
  Widget build(BuildContext context) {
    print(widget.title);

    return Scaffold(
      appBar: AppBar(
        title: Text("jake's Git"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  widget.subtitle,textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
