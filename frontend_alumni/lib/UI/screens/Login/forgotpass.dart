import 'package:alumni/UI/Componants/dialog_alert.dart';
import 'package:alumni/utilitis/constants/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
    var response = await http.post(ApiUrl.passwordReset, body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      setState(() {
        Dialogs.okDialog(context, 'Password Reset',
            'Password reset link has been sent to the registered email');
        _isLoading = false;
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
          'Reset Password',
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
