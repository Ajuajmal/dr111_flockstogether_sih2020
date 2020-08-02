import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:alumni/UI/Componants/bottombar.dart';

class ReferralMsg extends StatefulWidget {
  @override
  _ReferralMsgState createState() => _ReferralMsgState();
}

class _ReferralMsgState extends State<ReferralMsg> {
  final _formKey = GlobalKey<FormState>();
  final referralController = new TextEditingController();
  bool _isLoading = false;

  final referralValid = MultiValidator(
    [
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(10,
          errorText: 'password must be at least 10 characters long'),
    ],
  );

  reqRefferal(String msg) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var userid = sharedPreferences.getInt('userid');
    print(token);
    print(userid);

    Map data = {
      'request_to': userid.toString(),
      'token': token,
      'request_note': msg,
    };
    var response = await http
        .post('https://www.alumni-cucek.ml/api/ref/create/', body: data);

    var jsonData = json.decode(response.body);
    print(jsonData);
    if (response.statusCode == 201) {
      setState(
        () {
          _isLoading = false;
          sharedPreferences.remove('userid');
          _onAlertButtonPressed(context);
        },
      );
    } else {
      setState(
        () {
          _isLoading = false;
          _errorScreen(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral Request'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(40),
            child: Text(
              'Referral Request',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: TextFormField(
                      validator: referralValid,
                      controller: referralController,
                      maxLines: 6,
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Message',
                      ),
                    ),
                  ),
                  Container(
                    width: 420,
                    padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : FlatButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                reqRefferal(referralController.text);
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Referral ",
    desc: "Refeeral request has been sent successfully",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BottomBarHome(),
              ),
              (Route<dynamic> route) => false);
        },
        width: 120,
      )
    ],
  ).show();
}

_errorScreen(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Referral ",
    desc: "You have already requested for the refferal",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BottomBarHome(),
              ),
              (Route<dynamic> route) => false);
        },
        width: 120,
      )
    ],
  ).show();
}
