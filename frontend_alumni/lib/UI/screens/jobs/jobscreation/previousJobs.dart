import 'dart:async';
import './applicants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyPostings extends StatefulWidget {
  @override
  _MyPostings createState() => new _MyPostings();
}

class _MyPostings extends State<MyPostings> {
  bool _isLoading = false;

  selectJobName(int id) async {
    print(id);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt('id', id);
    });
    print(sharedPreferences.getInt('id'));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicantsList(),
      ),
    );
  }

  TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    print(token);
    final response = await http.get(url + token);
    final responseJson = json.decode(response.body);

    print(responseJson);
    print(response.statusCode);

    setState(
      () {
        _userDetails = [];
        for (Map user in responseJson) {
          _userDetails.add(UserDetails.fromJson(user));
        }
        _isLoading = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: Text(
                'My Postings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[400],
                ),
              ),
            ),
          ),
          new Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : new ListView.builder(
                    itemCount: _userDetails.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                        child: new Card(
                          elevation: 10,
                          color: Colors.grey[100],
                          child: FlatButton(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 150,
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              _userDetails[index].jobName,
                                              style: TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 50,
                                              maxWidth: 200,
                                            ),
                                            child: Container(
                                              child: Text(
                                                _userDetails[index]
                                                    .jobDescription,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          _userDetails[index].lastDate,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              print(_userDetails[index].jobId);
                              selectJobName(_userDetails[index].jobId);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

List<UserDetails> _userDetails = [];

final String url = 'https://www.alumni-cucek.ml/api/get/jobs/byemployer/';

class UserDetails {
  final int jobId;
  final String jobName, jobDescription, lastDate;

  UserDetails({this.jobName, this.jobDescription, this.lastDate, this.jobId});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      jobName: json['job_name'],
      jobDescription: json['description'],
      lastDate: json['last_date'],
      jobId: json['id'],
    );
  }
}
