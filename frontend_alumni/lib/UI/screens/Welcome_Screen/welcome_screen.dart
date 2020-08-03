import 'package:alumni/UI/Componants/bottombar.dart';
import 'package:alumni/UI/screens/Registration/college_selection.dart';
import 'package:alumni/UI/screens/filters/filters.dart';
import 'package:alumni/utilitis/constants/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:alumni/UI/screens/Login/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    checkUserType() async {
      String loginToken = await storage.read(key: 'accesstoken');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      };
      var response = await http.get(
          ApiUrl.baseUrl + ApiUrl.endPoint + ApiUrl.userTypeCheck,
          headers: requestHeaders);
      var jsonData = json.decode(response.body);
      print(jsonData);
      setState(
        () {
          _isLoading = false;
        },
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomBarHome()),
          (route) => false);
    }

    checkLoginStatus() async {
      String loginToken = await storage.read(key: 'accesstoken');

      if (loginToken != null) {
        bool isTokenExpired = JwtDecoder.isExpired(loginToken);
        print(isTokenExpired);

        if (isTokenExpired == false) {
          checkUserType();
        } else {
          String refreshToken = await storage.read(key: 'refreshtoken');
          bool isTokenExpired = JwtDecoder.isExpired(refreshToken);
          if (isTokenExpired == false) {
            print('refresh token is alive $refreshToken');
            Map data = {
              'refresh': refreshToken,
            };
            var response = await http.post(
              ApiUrl.baseUrl + ApiUrl.endPoint + ApiUrl.refreshToken,
              body: jsonEncode(data),
              headers: {"Content-Type": "application/json"},
            );
            var jsonData = json.decode(response.body);
            print(jsonData);
            if (response.statusCode == 200) {
              await storage.write(
                  key: 'accesstoken', value: jsonData['access']);
              checkUserType();
            }
          } else {
            print('need to login again');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginForm(),
              ),
            );
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginForm(),
          ),
        );
      }
    }

    Future<bool> _onbackbutton() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure, you want to exit? '),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onbackbutton,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.lightBlue[300], Colors.lightBlue[200]],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 130, 10, 10),
                child: Text(
                  'WELCOME TO ALUMNI PORTAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset('assets/images/goa.png'),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 5),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : RaisedButton(
                              color: Colors.cyan[600],
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                checkLoginStatus();
                              },
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                      child: RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.cyan[600],
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.leftToRightWithFade,
                              child: CollegeSearch(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
