import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  bool _isLoading = false;
  Future<Null> getUserDetails() async {
    final response =
        await http.get('https://www.alumni-cucek.ml/api/get/events/');
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event List'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
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
                        return new Card(
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    _userDetails[index].eventName,
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
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 80, 10),
                                    child: Text(
                                      _userDetails[index]
                                          .description
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 16,
                                        backgroundColor: Colors.yellow[50],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 80, 10),
                                      child: Text(
                                        'Location :',
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
                                          _userDetails[index].location,
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
                                          EdgeInsets.fromLTRB(20, 10, 65, 10),
                                      child: Text(
                                        'eventDate :',
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
                                          _userDetails[index].eventDate,
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
                                          EdgeInsets.fromLTRB(20, 10, 90, 10),
                                      child: Text(
                                        'creator :',
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
                                          _userDetails[index].creator,
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
                                          EdgeInsets.fromLTRB(20, 10, 50, 10),
                                      child: Text(
                                        'eventStatus :',
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
                                          _userDetails[index].eventStatus,
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
  final String eventName;
  final String creator, eventDate, description, eventStatus, location;

  UserDetails(
      {this.eventName,
      this.creator,
      this.eventDate,
      this.description,
      this.location,
      this.eventStatus});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      creator: json['creator'],
      eventDate: json['event_date'],
      eventName: json['event_name'],
      description: json['description'],
      eventStatus: json['event_status'],
      location: json['location'],
    );
  }
}
