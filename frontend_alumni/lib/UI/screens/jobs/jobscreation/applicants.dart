import 'dart:async';
import './applicantdetails.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApplicantsList extends StatefulWidget {
  @override
  _ApplicantsList createState() => new _ApplicantsList();
}

class _ApplicantsList extends State<ApplicantsList> {
  bool _isLoading = false;
  applcationFull(int id) async {
    print(id);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', id);
    print(sharedPreferences.getInt('id'));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicantDetails(),
      ),
    );
  }

  TextEditingController controller = new TextEditingController();

  int id;

  Future<Null> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getInt('id');
      print('detailed-Applying$id');
    });

    final response = await http
        .get('https://www.alumni-cucek.ml/api/get/job/$id/applications/');
    final responseJson = json.decode(response.body);

    setState(() {
      _userDetails = [];
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
        _isLoading = false;
      }
    });
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Applications'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: Text(
                'Applicants',
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
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                        child: new Card(
                          elevation: 10,
                          child: FlatButton(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        child: Text(
                                          _userDetails[index].name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              print(_userDetails[index].id);
                              applcationFull(_userDetails[index].id);
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

final String url = 'https://www.alumni-cucek.ml/api/get/job/';

class UserDetails {
  final int id;
  final String name;

  UserDetails({this.name, this.id});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      name: json['name'],
      id: json['id'],
    );
  }
}
