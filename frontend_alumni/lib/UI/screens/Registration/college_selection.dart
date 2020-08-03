import 'package:alumni/UI/screens/Registration/select_course.dart';
import 'package:alumni/utilitis/constants/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:alumni/utilitis/screensize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class CollegeSearch extends StatefulWidget {
  @override
  _CollegeSearchState createState() => new _CollegeSearchState();
}

class _CollegeSearchState extends State<CollegeSearch> {
  ScreenSize screenSize;
  TextEditingController controller = new TextEditingController();
  Future<Null> getCollegeList() async {
    final response =
        await http.get(ApiUrl.baseUrl + ApiUrl.endPoint + ApiUrl.collegeList);
    final responseJson = json.decode(response.body);

    setState(() {
      //_userDetails = [];
      print(_userDetails);
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  selectCollege(String collegeId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('collegeId', collegeId);
    print(
      sharedPreferences.getString('collegeId'),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectCourse(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCollegeList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = ScreenSize().getSize(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        "Choose Your College",
                        style: TextStyle(
                            color: Color(0xff142850),
                            fontSize: 28,
                            fontFamily: "SourceSansPro"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Container(
                      child: Image.asset(
                        'assets/images/college.jpg',
                        height: screenSize.height / 3,
                        width: screenSize.width,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: new Card(
                      elevation: 10,
                      shadowColor: Colors.blue[50],
                      child: new ListTile(
                        leading: new Icon(Icons.search),
                        title: new TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: onSearchTextChanged,
                        ),
                        trailing: new IconButton(
                          icon: new Icon(Icons.cancel),
                          onPressed: () {
                            controller.clear();
                            _searchResult = [];
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _searchResult.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return FlatButton(
                          onPressed: () {
                            selectCollege(_searchResult[i].user);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                            child: new Card(
                              color: Colors.grey[200],
                              elevation: 10,
                              child: new ListTile(
                                leading: new CircleAvatar(
                                  backgroundImage: new NetworkImage(
                                    _searchResult[i].profileUrl,
                                  ),
                                ),
                                title: new Text(_searchResult[i].name),
                              ),
                              margin: const EdgeInsets.all(0.0),
                            ),
                          ),
                        );
                      },
                    )
                  : new ListView.builder(
                      shrinkWrap: true,
                      itemCount: _userDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                          child: FlatButton(
                            onPressed: () {
                              selectCollege(_userDetails[index].user);
                            },
                            child: new Card(
                              color: Colors.grey[200],
                              elevation: 10,
                              child: new ListTile(
                                leading: new CircleAvatar(
                                  backgroundImage: new NetworkImage(
                                    _userDetails[index].profileUrl,
                                  ),
                                ),
                                title: new Text(_userDetails[index].name),
                              ),
                              margin: const EdgeInsets.all(0.0),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult = [];
    print(text);
    _userDetails.forEach((userDetail) {
      if (userDetail.name.contains(text)) _searchResult.add(userDetail);
    });
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

class UserDetails {
  final String user, name, profileUrl;

  UserDetails(
      {this.user,
      this.name,
      this.profileUrl =
          'https://cdn4.iconfinder.com/data/icons/education-line-color-nerd-power/512/University-512.png'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      user: json['user'].toString(),
      name: json['name'],
    );
  }
}
