import 'package:alumni/UI/Componants/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'jobscreate4.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';

class JobsCreate3 extends StatefulWidget {
  final String jobTitle;
  final String location;
  final String jobType;
  JobsCreate3({this.jobTitle, this.location, this.jobType});
  @override
  _JobsCreate3State createState() => _JobsCreate3State();
}

class _JobsCreate3State extends State<JobsCreate3> {
  final _formKey = GlobalKey<FormState>();
  final cpName = new TextEditingController();
  final baseSalary = new TextEditingController();
  final lastDate = new TextEditingController();
  final reqvalidator = RequiredValidator(errorText: 'This is a required field');
  @override
  Widget build(BuildContext context) {
    String jobType = widget.jobType;
    String jobTitle = widget.jobTitle;
    String location = widget.location;
    return Scaffold(
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
                        'Create',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
                          child: ReusableWidgets().customTextfield(
                            'Company Name',
                            cpName,
                            Icon(Icons.place),
                            false,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: ReusableWidgets().customTextfield(
                            'Base Salary',
                            baseSalary,
                            Icon(Icons.monetization_on),
                            false,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: ReusableWidgets().customTextfield(
                              'Last Date (yyyy-mm-dd)',
                              lastDate,
                              Icon(Icons.date_range),
                              false),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: 60,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                        child: JobsCreate4(
                                          jobTitle: jobTitle,
                                          jobType: jobType,
                                          location: location,
                                          companyName: cpName.text,
                                          salary: baseSalary.text,
                                          lastDate: lastDate.text,
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
