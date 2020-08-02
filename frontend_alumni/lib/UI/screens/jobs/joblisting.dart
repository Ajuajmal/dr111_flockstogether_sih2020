import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './jobdetailed.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JobListing extends StatefulWidget {
  @override
  _JobListingState createState() => new _JobListingState();
}

class _JobListingState extends State<JobListing> {
  bool _isLoading = false;
  selectJobName(int id) async {
    print(id);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', id);
    print(sharedPreferences.getInt('id'));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailedView(),
      ),
    );
  }

  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      _userDetails = [];
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
      _isLoading = false;
    });
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
        title: new Text('Job List'),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
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
                            color: Colors.grey[200],
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
                                                maxWidth: 200,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  _userDetails[index].description,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'OpenSans'),
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
                                          child:
                                              Text(_userDetails[index].lastDate),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                print(_userDetails[index].id);
                                selectJobName(_userDetails[index].id);
                              },
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

final String url = 'https://alumni-cucek.herokuapp.com/api/get/jobs/';

class UserDetails {
  final int id;
  final String jobName, description, lastDate;

  UserDetails({this.jobName, this.description, this.lastDate, this.id});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      jobName: json['job_name'],
      description: json['description'],
      lastDate: json['last_date'],
      id: json['id'],
    );
  }
}
