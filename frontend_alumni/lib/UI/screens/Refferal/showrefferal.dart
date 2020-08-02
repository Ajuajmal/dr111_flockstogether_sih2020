import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowReferrals extends StatefulWidget {
  @override
  _ShowReferralsState createState() => _ShowReferralsState();
}

class _ShowReferralsState extends State<ShowReferrals> {
  bool _isLoading=false;
  Future<Null> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    final response = await http.get(
        'https://www.alumni-cucek.ml/api/get/refrequest/$token/requested/');
    final responseJson = json.decode(response.body);

    setState(() {
    _userDetails=[];
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
      _isLoading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading=true;

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Referral Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child:_isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : new ListView.builder(
                itemCount: _userDetails.length,
                itemBuilder: (context, index) {
                  return new Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              _userDetails[index].userName,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 50,
                              maxWidth: 350,
                            ),
                            child: Container(
                              child: Text(
                                _userDetails[index].reqNote,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<UserDetails> _userDetails = [];

class UserDetails {
  final int id;
  final String userName;
  final String reqNote;

  UserDetails({this.id, this.userName, this.reqNote});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      userName: json['username'],
      id: json['id'],
      reqNote: json['request_note'],
    );
  }
}
