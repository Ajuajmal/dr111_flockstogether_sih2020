import 'package:alumni/UI/Componants/app_bar.dart';
import 'package:alumni/UI/Componants/reusable_widgets.dart';
import 'package:alumni/UI/screens/Login/forgotpass.dart';
import 'package:alumni/UI/screens/Verification/verification.dart';
import 'package:alumni/utilitis/constants/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:alumni/UI/screens/Registration/emailactivation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:alumni/UI/Componants/bottombar.dart';
import 'package:alumni/UI/Componants/dialog_alert.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final storage = new FlutterSecureStorage();

  bool _isLoading = false;

  userTypeCheck() async {
    String accessToken = await storage.read(key: 'accesstoken');
    print(accessToken);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var response = await http.get(
        ApiUrl.baseUrl + ApiUrl.endPoint + ApiUrl.userTypeCheck,
        headers: requestHeaders);
    var jsonData = json.decode(response.body);
    print(jsonData);
    setState(() {
      _isLoading = false;
    });
    if (jsonData['user_type'] == 5) {
      setState(() {
        _isLoading = false;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomBarHome()),
            (route) => false);
      });
    }
    if (jsonData['is_alumni'] == true) {
      print(jsonData['verify_status']);
      if (jsonData['verify_status'] == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BottomBarHome(),
            ),
            (Route<dynamic> route) => false);
      } else if (jsonData['verify_status'] == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => VerifySignUp(),
            ),
            (Route<dynamic> route) => false);
      }
    } else if (jsonData['is_student'] == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BottomBarHome(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  logIn(String username, String password) async {
    Map data = {
      'username': username,
      'password': password,
    };

    var response = await http
        .post(ApiUrl.baseUrl + ApiUrl.endPoint + ApiUrl.loginApi, body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);

    if (response.statusCode == 200) {
      await storage.write(key: 'accesstoken', value: jsonData['access']);
      await storage.write(key: 'refreshtoken', value: jsonData['refresh']);

      userTypeCheck();
    } else if (response.statusCode == 400) {
      setState(
        () {
          _isLoading = false;
        },
      );
      print(response.statusCode);
      if (jsonData['non_field_errors'][0] ==
          'Unable to log in with provided credentials.') {
        Dialogs.okDialog(context, 'Login Error',
            'Unable to log in with provided credentials');
      } else if (jsonData['non_field_errors'][0] ==
          'Either activate or request for new account activation link.') {
        Dialogs.okDialog(context, 'Login Error',
            'Activate your account to start using the application');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar('ALUMNI LOGIN'),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Roboto',
                      color: Colors.blue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 130, 30, 10),
                      child: ReusableWidgets().customTextfield(
                        'User Name',
                        usernameController,
                        Icon(FontAwesome.user),
                        false,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: ReusableWidgets().customTextfield(
                        'Password',
                        passwordController,
                        Icon(MaterialIcons.security),
                        true,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 90,
                          padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      logIn(
                                        usernameController.text,
                                        passwordController.text.toString(),
                                      );
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                        textColor: Colors.blue,
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmailActivation(),
                            ),
                          );
                        },
                        textColor: Colors.blue,
                        child: Text(
                          'Activate Your account',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                          ),
                        ),
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
