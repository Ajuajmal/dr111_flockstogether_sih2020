import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alumni/UI/Componants/Search/searchedprofile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  selectUserName(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('username', username);
    print(sharedPreferences.getString('username'));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchedProfile(),
      ),
    );
  }

  TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      _userDetails = [];
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Find Alumni'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
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
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
              child: new ListView.builder(
            itemCount: _searchResult.length,
            itemBuilder: (context, i) {
              return FlatButton(
                child: new Card(
                  child: new ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: new NetworkImage(
                        'https://www.kindpng.com/picc/m/269-2697881_computer-icons-user-clip-art-transparent-png-icon.png',
                      ),
                    ),
                    title: new Text(_searchResult[i].firstName +
                        ' ' +
                        _searchResult[i].lastName),
                    subtitle: new Text(_searchResult[i].userName),
                  ),
                  margin: const EdgeInsets.all(0.0),
                ),
                onPressed: () {
                  print(_searchResult[i].userName);
                  selectUserName(_searchResult[i].userName);
                },
              );
            },
          )),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.contains(text) ||
          userDetail.lastName.contains(text) ||
          userDetail.userName.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://www.alumni-cucek.ml/api/user/list/';

class UserDetails {
//  final int id;
  final String firstName, lastName, userName;

  UserDetails({this.firstName, this.lastName, this.userName});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      firstName: json['first_name'],
      lastName: json['last_name'],
      userName: json['username'],
    );
  }
}

//Profile Page
