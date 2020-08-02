import 'package:alumni/UI/screens/Verification/manualverification.dart';
import 'package:alumni/UI/screens/Verification/otpform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VerifySignUp extends StatefulWidget {
  @override
  _VerifySignUpState createState() => _VerifySignUpState();
}

class _VerifySignUpState extends State<VerifySignUp> {
  bool _isLoading = false;
  String emailForVerification;
  final String accountNumberResetapi =
      'https://www.alumni-cucek.ml/api/auth/account/verify/alumni/sms/';

  activateAccountMobile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    Map data = {
      'token': token,
    };
    var response = await http.post(accountNumberResetapi, body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);
    if (response.statusCode == 201) {
      setState(
        () {
          _isLoading = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpSubmit(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 400,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RaisedButton(
                      color: Colors.blue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'Using Contact No.',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        activateAccountMobile();
                      },
                    ),
            ),
          ),
          SizedBox(
            width: 400,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RaisedButton(
                      color: Colors.blue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'Manual Verification',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManualVerification(),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
