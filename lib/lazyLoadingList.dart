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
  List<dynamic> apiData = [];
  List<dynamic> realData = [];
  bool showLoader = false;
  ScrollController _scrollController = ScrollController();
  int _crrentMax = 8;

  callapi() async {
    setState(() {
      showLoader = true;
    });
    var a = await h.get(Uri.parse(
        'https://api.github.com/users/JakeWharton/repos?page=1&per_page=15'));
    setState(() {
      apiData = jsonDecode(a.body);
      showLoader = false;
      if (8 < apiData.length) {
        for (int a = 0; a < 8; a++) {
          realData.add(apiData[a]);
          _crrentMax = a;
        }
      } else {
        realData.addAll(apiData);
        _crrentMax = apiData.length;
      }
    });
  }

  @override
  void initState() {
    callapi();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() {
    print("Get MOre List");
    if (realData.length < apiData.length) {
      if (_crrentMax + 5 < apiData.length) {
        for (int a = _crrentMax; a < _crrentMax + 5; a++) {
          realData.add(apiData[a]);
          _crrentMax = a;
        }
        setState(() {});
      } else {
        realData.clear();
        realData.addAll(apiData);
        _crrentMax = apiData.length;
        setState(() {});
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      ),
      body: showLoader == true
          ? Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: realData.length + 1,
                  itemBuilder: (BuildContext ctx, int i) {
                    if (i == realData.length) {
                      if (realData.length < apiData.length) {
                        return SizedBox(
                            height: 56,
                            child: Center(
                                child: CupertinoActivityIndicator(
                              radius: 22,
                            )));
                      } else {
                        return Container();
                      }
                    } else {
                      return InkWell(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => detailedpage(
                          //           title: '${realData[i]['name']}',
                          //           subtitle: '${realData[i]['description']}',
                          //         )));

                          // paySound();
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              '${realData[i]['name']}',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${realData[i]['description']}',
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
                                                  '${realData[i]['language']}',
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
                                                  '${realData[i]['open_issues']}',
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
                                                  '${realData[i]['watchers']}',
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
                    }
                  }),
            ),
    );
  }
}
