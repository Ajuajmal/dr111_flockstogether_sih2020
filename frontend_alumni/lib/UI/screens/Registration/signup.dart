import 'package:alumni/UI/screens/Welcome_Screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:alumni/UI/screens/Login/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_icons/flutter_icons.dart';
import './newbatch.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isLoading = false;
  String selBatch;
  String selDept;
  final emailController = new TextEditingController();
  final usernameController = new TextEditingController();
  final firstnameController = new TextEditingController();
  final lastnameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final contactcontroller = new TextEditingController();
  bool _userNameExists = false;
  bool _contactExists = false;
  bool _emailExists = false;

  final requiredValidator =
      RequiredValidator(errorText: 'This field is required');
  final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 characters long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character'),
    ],
  );

  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Sign Up",
      desc:
          "You have successfully Signed Up ! activation link has been sent to your email",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          width: 120,
        )
      ],
    ).show();
  }

  final _formKey = GlobalKey<FormState>();
  String _validateUserName(String userName) {
    if (userName.length < 5) {
      return 'Username must be atleast 5 characters';
    }

    if (_userNameExists) {
      _userNameExists = false;
      return 'Username already taken';
    }

    return null;
  }

  String validateMobile(String number) {
    if (number.length != 10) {
      return 'Mobile Number must be of 10 digit';
    }
    if (_contactExists) {
      _contactExists = false;
      return 'contact already exists, please login';
    } else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Enter Valid Email';
    if (_emailExists) {
      _emailExists = false;
      return 'Email already exists, please login';
    } else
      return null;
  }

  final String batchApi =
      'https://www.alumni-cucek.ml/api/auth/account/get/batches/';

  final String deptApi =
      'https://www.alumni-cucek.ml/api/auth/account/get/departments/';

  List data = List();
  List deptData = List();
  Future<String> getBatchApi() async {
    var res = await http.get(batchApi);
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    return "Sucess";
  }

  Future<String> getDeptApi() async {
    var res = await http.get(deptApi);
    var resBody = json.decode(res.body);
    setState(() {
      deptData = resBody;
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getBatchApi();
    this.getDeptApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  signUp(String email, String username, String fn, String ln, String password,
      String dept, int batch, String contact) async {
    Map data = {
      'email': email,
      'username': username,
      'first_name': fn,
      'last_name': ln,
      'password': password,
      "alumni": {"department": dept, "batch": batch, "contact": contact},
    };

    var response = await http.post(
      "https://www.alumni-cucek.ml/api/auth/register/",
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    var jsonData = json.decode(response.body);
    print(jsonData);
    if (response.statusCode == 201) {
      setState(
        () {
          _isLoading = false;

          _onAlertButtonPressed(context);
        },
      );
    } else if (response.statusCode == 400) {
      print(jsonData);
      print(jsonData['non_field_errors'][0]);
      setState(() {
        _isLoading = false;
      });

      if (jsonData['non_field_errors'][0] == 'Username already taken') {
        setState(() {
          _userNameExists = true;
        });
      } else if (jsonData['non_field_errors'][0] == 'contact already taken') {
        setState(() {
          _contactExists = true;
        });
      } else if (jsonData['non_field_errors'][0] == 'Email already exists') {
        setState(() {
          _emailExists = true;
        });
      }
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
          'Alumni Portal',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(40),
              child: Center(
                child: Text(
                  'Create An Account',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 180,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                              prefixIcon: Icon(FontAwesome.user_circle),
                            ),
                            validator: requiredValidator,
                            style:
                                TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                            controller: firstnameController,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(FontAwesome.user_circle),
                                labelText: 'Last Name',
                              ),
                              validator: requiredValidator,
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: "Roboto"),
                              controller: lastnameController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email)),
                      style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      controller: emailController,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          prefixIcon: Icon(FontAwesome.user)),
                      style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      validator: _validateUserName,
                      controller: usernameController,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contact',
                          prefixIcon: Icon(FontAwesome.phone)),
                      style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      validator: validateMobile,
                      controller: contactcontroller,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: new DropdownButton(
                          dropdownColor: Colors.grey[200],
                          items: data.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(
                                item['batch'],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              selBatch = newVal;
                              print(selBatch);
                            });
                          },
                          hint: Text('Choose Batch'),
                          elevation: 20,
                          value: selBatch,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: new DropdownButton(
                            isDense: true,
                            dropdownColor: Colors.grey[200],
                            items: deptData.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(
                                  item['branch'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selDept = val;
                                print(val);
                              });
                            },
                            hint: Text('Choose Department'),
                            elevation: 20,
                            value: selDept,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Text(
                          'Add Batch',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                        child: FloatingActionButton(
                          backgroundColor: Colors.teal[300],
                          child: Icon(
                            Icons.add,
                            size: 15,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBatch(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(MaterialIcons.security)),
                      validator: passwordValidator,
                      controller: passwordController,
                      style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(MaterialIcons.security),
                        labelText: 'Confirm Password',
                      ),
                      validator: (val) =>
                          MatchValidator(errorText: 'passwords do not match')
                              .validateMatch(val, passwordController.text),
                      style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text('Sign Up'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    signUp(
                                        emailController.text,
                                        usernameController.text,
                                        firstnameController.text,
                                        lastnameController.text,
                                        passwordController.text,
                                        selDept,
                                        int.parse(selBatch),
                                        contactcontroller.text);
                                  }
                                },
                              ),
                      ),
                      Container(
                        //height: 50,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginForm(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
