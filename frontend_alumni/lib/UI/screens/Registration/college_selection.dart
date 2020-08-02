import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alumni/utilitis/screensize.dart';

class CollegeSearch extends StatefulWidget {
  @override
  _CollegeSearchState createState() => new _CollegeSearchState();
}

class _CollegeSearchState extends State<CollegeSearch> {
  ScreenSize screenSize;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenSize = ScreenSize().getSize(context);
    return SafeArea(
      child: Scaffold(
        body: new ListView(
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
                          onSearchTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return FlatButton(
                  child: new ListTile(
                    title: new Text(_searchResult[i].firstName +
                        ' ' +
                        _searchResult[i].lastName),
                  ),
                  onPressed: () {
//                      print(_searchResult[i].userName);
//                      selectUserName(_searchResult[i].userName);
                  },
                );
              },
            ),
          ],
        ),
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
