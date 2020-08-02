import 'package:alumni/UI/screens/jobs/Jobs2.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';

class JobsOne extends StatefulWidget {
  @override
  _JobsOneState createState() => _JobsOneState();
}

class _JobsOneState extends State<JobsOne> {
  final _formKey = GlobalKey<FormState>();
  final requiredValidator =
      RequiredValidator(errorText: 'This field is required');

  final nameController = new TextEditingController();

  final emailController = new TextEditingController();

  final contactController = new TextEditingController();

  final emailval = MultiValidator(
    [
      RequiredValidator(errorText: 'This field is required'),
      EmailValidator(errorText: 'Provide a valid email')
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jobs'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    //autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextFormField(
                            controller: nameController,
                            validator: requiredValidator,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.verified_user),
                            ),
                            style:
                                TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: emailController,
                            validator: emailval,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            style:
                                TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: contactController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            validator: requiredValidator,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            style:
                                TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text('Next'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .leftToRightWithFade,
                                        child: JobsTwo(
                                          name: nameController.text,
                                          email: emailController.text,
                                          contact: contactController.text,
                                        ),
                                      ),
                                    );
                                  }
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
          ],
        ),
      ),
    );
  }
}
