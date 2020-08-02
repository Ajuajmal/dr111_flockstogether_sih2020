import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ApplicantDetails extends StatefulWidget {
  @override
  _ApplicantDetails createState() => _ApplicantDetails();
}

class _ApplicantDetails extends State<ApplicantDetails> {
  bool _isLoading = false;
  int applicationId;
  int id;
  String name = '';
  String qnsAsked = '';
  String work = '';
  final String short = 'SH';
  String organization = '';
  String email = '';
  String contact = '';
  String linkedin = '';
  String twitter = '';
  String facebook = '';
  String cv = '';
  String ansToEmployer = '';
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  preFetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getInt('id');
      print('detailed$id');
    });

    var response = await http
        .get('https://www.alumni-cucek.ml/api/get/job/$id/application/');
    print(response.body);
    var jsonData = json.decode(response.body);
    setState(() {
      applicationId = jsonData[0]['id'];
      name = jsonData[0]['name'];
      ansToEmployer = jsonData[0]['answers_to_employer'];
      work = jsonData[0]['work'];
      organization = jsonData[0]['organization'];
      email = jsonData[0]['email'];
      contact = jsonData[0]['contact'];
      linkedin = jsonData[0]['linkedin'];
      twitter = jsonData[0]['twitter'];
      facebook = jsonData[0]['facebook'];
      qnsAsked = jsonData[0]['questions_to_employer'];
      cv = jsonData[0]['resume'];
      _isLoading = false;
    });
  }

  shortList() async {
    print(short);
    print(applicationId);

    Map data = {
      'application_status': short.toString(),
      'id': applicationId.toString(),
    };
    var response = await http.post(
        'https://www.alumni-cucek.ml/api/update/job/application/status/',
        body: data);

    var jsonData = json.decode(response.body);

    print(jsonData);
    if (response.statusCode == 201) {
      setState(() {
        _isLoading = false;
        _onAlertButtonPressed(context);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();
    preFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicant Details'),
      ),
      body: Container(
//      color: Colors.grey[300],
        margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                        color: Colors.grey[300],
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
//                            answers
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Answers To The Questions',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: 100,
                                                  maxWidth: 400,
                                                ),
                                                child: Container(
                                                  child: Text(
                                                    ' ' + ansToEmployer,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 15),
                                      child: SizedBox(
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

//                            Skills
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Work',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(' ' + work),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 15),
                                      child: SizedBox(
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

//                              organization
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Organization',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(' ' + organization),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 15),
                                      child: SizedBox(
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

//                              email
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Email',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(' ' + email),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 15),
                                      child: SizedBox(
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

//                              contact
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Contact',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('$contact'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 15),
                                      child: SizedBox(
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Questions Asked',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: 100,
                                                  maxWidth: 400,
                                                ),
                                                child: Container(
                                                  child: Text(
                                                    ' ' + qnsAsked,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 15),
                                      child: SizedBox(
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
//

                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 55, 10),
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
                                                _launchURL(facebook);
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
                                          padding: EdgeInsets.fromLTRB(
                                              18, 10, 63, 10),
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
                                                    padding:
                                                        EdgeInsets.fromLTRB(
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
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              22, 10, 80, 10),
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
                                                    padding:
                                                        EdgeInsets.fromLTRB(
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
//                            Open Resume
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 30, 20, 20),
                                      width: 175,
                                      child: FlatButton(
                                        color: Colors.blue,
                                        child: Text(
                                          'Open Resume',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          print(cv);
                                          _launchURL(cv);
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 30, 20, 20),
                                      width: 175,
                                      child: FlatButton(
                                        color: Colors.blue,
                                        child: Text(
                                          'Short List',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isLoading = true;
                                          });

                                          shortList();
                                        },
                                      ),
                                    ),
//                              Container(
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text('Approved'),
//                                    SizedBox(height: 10,),
//                                    Text('Waiting List'),
//                                    SizedBox(height: 10,),
//                                    Text('Rejected'),
//                                  ],
//                                ),
//                              ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Short Listing",
    desc: "The application short listed successfully",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
