import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as h;
import 'dart:convert';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'checkAuth.dart';

class jakes extends StatefulWidget {
  @override
  _jakesState createState() => _jakesState();
}

class _jakesState extends State<jakes> {
  AudioPlayer audioPlayer = AudioPlayer();
  ConfettiController _controllerCenter;
  static const alarmAudioPath = "assets/audio/assets_audios_sec_tone.mp3";
  List<dynamic> b = [];
  bool showLoader = false;

  callapi() async {
    setState(() {
      showLoader = true;
    });
    var a = await h.get(Uri.parse(
        'https://api.github.com/users/JakeWharton/repos?page=1&per_page=15'));
    setState(() {
      b = jsonDecode(a.body);
      showLoader = false;
    });
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 2;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  ScrollController _scrollController = ScrollController();
  int _crrentMax = 10;

  @override
  void initState() {
    callapi();
    _scrollController.addListener(() {
      // if (_scrollController.position.pixels ==
      //     _scrollController.position.pixels) {
      //   _getMoreList();
      print(_scrollController.position.pixels);
      // }
    });
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  _getMoreList() {
    print("Get MOre List");
    for (int i = _crrentMax; i < _crrentMax + 10; i++) {
      b.add("  ${i + 1}");
    }
    _crrentMax = _crrentMax + 10;
    setState(() {});
  }

  void paySound() async {
    _controllerCenter.play();
    print('try to playing ');
    int result = await audioPlayer.play(alarmAudioPath, isLocal: true);
    print('done playing ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "jake's Git",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => authCheck()));
              },
              icon: Icon(Icons.lock))
        ],
      ),
      body: showLoader == true
          ? Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: _controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      // don't specify a direction, blast randomly
                      shouldLoop: false,
                      // start again as soon as the animation is finished
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ],
                      // manually specify the colors to be used
                      createParticlePath:
                          drawStar, // define a custom shape/path.
                    ),
                  ),
                  ListView.builder(
                      itemCount: b.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        return InkWell(
                          onTap: () {
                            paySound();
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.book_rounded,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${b[i]['name']}',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${b[i]['description']}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Container(
                                                  child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.aspect_ratio_rounded,
                                                    size: 20,
                                                  ),
                                                  // Icon(
                                                  //   Icons.navigate_next,
                                                  //   size: 20,
                                                  // ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    '${b[i]['language']}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Icon(
                                                    Icons.security_sharp,
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    '${b[i]['open_issues']}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Icon(Icons
                                                      .sentiment_very_satisfied_rounded),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    '${b[i]['watchers']}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),

                                        // Icon(
                                        //   Icons.book_rounded,
                                        //   size: 40,
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Color(0xffdde4e3),
                                height: 20,
                                thickness: 2,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
    );
  }
}
