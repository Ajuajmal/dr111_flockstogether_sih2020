import 'package:alumni/UI/screens/Refferal/showrefferal.dart';
import 'package:flutter/material.dart';
import './profile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ProfilePage(),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final String preFetachApi = 'https://www.alumni-cucek.ml/api/get/profile/';
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
  bool imageLoad = true;
  String imgUrl = '';

  preFetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var response = await http.get(preFetachApi + token);
    print(response.body);
    var jsonData = json.decode(response.body);
    setState(() {
      bio = jsonData['bio'];
      skills = jsonData['skills'];
      linkedin = jsonData['linkedin'];
      fb = jsonData['facebook'];
      work = jsonData['work'];
      organization = jsonData['organization'];
      twitter = jsonData['twitter'];
      username = jsonData['username'];
      firstName = jsonData['first_name'];
      lastName = jsonData['last_name'];
      imgUrl = jsonData['profile_pic'];
      imageLoad = false;
    });
  }

  @override
  void initState() {
    super.initState();
    preFetch();
  }

  @override
  Widget build(BuildContext context) {
    return imageLoad
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
                      image: NetworkImage(imgUrl), fit: BoxFit.fill),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                              color: Colors.blue[500],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 15, 20, 0),
                            child: FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ),
                                );
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 137, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 20, 10),
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
                              Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: FlatButton(
                                  child: Text(
                                    'Show Referral Requests',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans'),
                                  ),
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowReferrals(),
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
              ),
            ],
          );
  }
}
