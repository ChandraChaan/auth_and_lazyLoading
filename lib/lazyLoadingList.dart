import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as h;
import 'package:local_auth_app/navigation.dart';
import 'dart:convert';


class jakes extends StatefulWidget {
  @override
  _jakesState createState() => _jakesState();
}

class _jakesState extends State<jakes> {

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
    // _controllerCenter =
    //     ConfettiController(duration: const Duration(seconds: 1));
  }


  _getMoreList() {
    print("Get MOre List");
    for (int i = _crrentMax; i < _crrentMax + 10; i++) {
      b.add("  ${i + 1}");
    }
    _crrentMax = _crrentMax + 10;
    setState(() {});
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context)
        //             .push(MaterialPageRoute(builder: (context) => authCheck()));
        //       },
        //       icon: Icon(Icons.lock))
        // ],
      ),
      body: showLoader == true
          ? Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: b.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => detailedpage(
                                  title: '${b[i]['name']}',
                                  subtitle: '${b[i]['description']}',
                                )));

                        // paySound();
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
                  }),
            ),
    );
  }
}
