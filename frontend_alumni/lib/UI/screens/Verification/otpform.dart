import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:alumni/UI/screens/Verification/verification.dart';
import 'package:alumni/UI/Componants/bottombar.dart';

class OtpSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Verification'),
      ),
      body: OtpSubmitPage(),
    );
  }
}

class OtpSubmitPage extends StatefulWidget {
  @override
  _OtpSubmitPageState createState() => _OtpSubmitPageState();
}

class _OtpSubmitPageState extends State<OtpSubmitPage> {
  final String accountNumberResetapi =
      'https://www.alumni-cucek.ml/api/auth/account/verify/alumni/sms/check/';

  String otp;
  final _controller = TextEditingController();

  activateAccountMobile(String otp) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    Map data = {
      'token': token,
      'sms_token': otp,
    };
    var response = await http.post(accountNumberResetapi, body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);
    if (response.statusCode == 201) {
      if (jsonData['status'] == 'notverified') {
        notVerified(context);
      } else if (jsonData['status'] == 'failed') {
        wrongOtp(context);
      } else if (jsonData['status'] == 'verified') {
        successVerification(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          Container(
            child: FlatButton(
              child: Text('Submit'),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  otp = _controller.text;
                  print(otp);
                });
                activateAccountMobile(otp);
              },
            ),
          ),
        ],
      ),
    );
  }
}

successVerification(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "OTP Verification",
    desc: "The contact has been verified successfully",
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

wrongOtp(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Verification Failed",
    desc: "Wrong OTP provided, Please verify again",
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
                builder: (BuildContext context) => VerifySignUp(),
              ),
              (Route<dynamic> route) => false);
        },
        width: 120,
      )
    ],
  ).show();
}

notVerified(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Contact Verification",
    desc: "contact doesnt exist in the database, Do manual verification",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
