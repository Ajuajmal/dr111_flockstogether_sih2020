import 'package:alumni/UI/screens/Refferal/referralmsg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchedProfile extends StatefulWidget {
  @override
  _SearchedProfileState createState() => _SearchedProfileState();
}

class _SearchedProfileState extends State<SearchedProfile> {
  String bio = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String skills = '';
  String linkedin = '';
  String fb = '';
  String work = '';
  String organization = '';
  String twitter = '';
  bool imageLoad = false;
  String imgUrl = '';
  String department = '';
  String start = '';
  String end = '';
  bool _isLoading = false;
  int userId;
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  preFetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString('username');
    });

    print(username);

    var response = await http.get(
        'https://alumni-cucek.herokuapp.com/api/user/profile/get/$username/');
    print(response.body);
    var jsonData = json.decode(response.body);
    setState(() {
      userId = jsonData[0]['id'];

      sharedPreferences.setInt('userid', userId);
      bio = jsonData[0]['alumni']["alumniprofile"]['bio'];
      skills = jsonData[0]['alumni']["alumniprofile"]['skills'];
      linkedin = jsonData[0]['alumni']["alumniprofile"]['linkedin'];
      fb = jsonData[0]['alumni']["alumniprofile"]['facebook'];
      work = jsonData[0]['alumni']["alumniprofile"]['work'];
      organization = jsonData[0]['alumni']["alumniprofile"]['organization'];
      twitter = jsonData[0]['alumni']["alumniprofile"]['twitter'];
      firstName = jsonData[0]['first_name'];
      lastName = jsonData[0]['last_name'];
      department = jsonData[0]['alumni']['department'];
      start = jsonData[0]['alumni']['batch']['start'];
      end = jsonData[0]['alumni']['batch']['end'];
      imgUrl = jsonData[0]['alumni']["alumniprofile"]['profile_pic'];
      imageLoad = false;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _isLoading = true;
    imageLoad = true;
    super.initState();
    preFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Search'),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(imgUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.blue[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 80, 10),
                                        child: Text(
                                          'First Name :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            firstName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 80, 10),
                                        child: Text(
                                          'Last Name :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            lastName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue[400],
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 80, 10),
                                        child: Text(
                                          'Department :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            department,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 80, 10),
                                        child: Text(
                                          'Admission :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            start,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 80, 10),
                                        child: Text(
                                          'Pass Out  :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              8, 10, 20, 10),
                                          child: Text(
                                            end,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Bio',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans'),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    child: Text(
                                      bio,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[400],
                                          fontFamily: 'OpenSans'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              'Working Details',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'OpenSans'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 50, 10),
                                        child: Text(
                                          'Working Status :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            work,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue[400],
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 70, 10),
                                        child: Text(
                                          'Organization :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            organization,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue[400],
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20, 10, 137, 10),
                                        child: Text(
                                          'Skills:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: Text(
                                            skills,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue[400],
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              'Social Media',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'OpenSans'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(22, 10, 80, 10),
                                        child: Text(
                                          'Twitter',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: RaisedButton(
                                            color: Colors.blue,
                                            onPressed: () {
                                              _launchURL(twitter);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesome.twitter,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                                  child: Text(
                                                    "Twitter",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 55, 10),
                                        child: Text(
                                          'FaceBook :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: RaisedButton(
                                            color: Colors.blue,
                                            onPressed: () {
                                              _launchURL(fb);
                                            },
                                            child: Row(
                                              // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesome.facebook,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "FaceBook",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(18, 10, 63, 10),
                                        child: Text(
                                          'Linkedin :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 10, 20, 10),
                                          child: RaisedButton(
                                            color: Colors.blue,
                                            onPressed: () {
                                              _launchURL(linkedin);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesome.linkedin,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                                  child: Text(
                                                    "Linkedin",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: FlatButton(
                              child: Text(
                                'Request For Refferal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans'),
                              ),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReferralMsg(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
