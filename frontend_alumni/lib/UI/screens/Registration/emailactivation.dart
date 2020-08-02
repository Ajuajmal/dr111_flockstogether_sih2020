import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:alumni/UI/screens/Login/login.dart';

class EmailActivation extends StatefulWidget {
  @override
  _EmailActivationState createState() => _EmailActivationState();
}

class _EmailActivationState extends State<EmailActivation> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final emailval = MultiValidator(
    [
      RequiredValidator(errorText: 'This field is required'),
      EmailValidator(errorText: 'Provide a valid email')
    ],
  );

  final emailController = new TextEditingController();
  reset(String email) async {
    Map data = {
      'email': email,
    };
    var response = await http
        .post("https://www.alumni-cucek.ml/api/auth/account/reset", body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      setState(() {
        showAlertDialog(context);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Activate Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 200, 10, 20),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: emailController,
                  validator: emailval,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Registered Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FlatButton(
                      padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Reset Password'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          print(emailController.text);
                          reset(emailController.text);
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginForm(),
          ),
          (Route<dynamic> route) => false);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Email Activation"),
    content: Text("Activation link has been sent to your email"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
