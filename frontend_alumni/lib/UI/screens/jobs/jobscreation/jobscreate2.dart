import 'package:alumni/UI/Componants/app_bar.dart';
import 'package:alumni/UI/Componants/reusable_widgets.dart';

import './jobscreate3.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JobsCreate2 extends StatefulWidget {
  @override
  _JobsCreate2State createState() => _JobsCreate2State();
}

class _JobsCreate2State extends State<JobsCreate2> {
  final _formKey = GlobalKey<FormState>();
  final jobTitleController = new TextEditingController();
  final locController = new TextEditingController();

  String jobType;
  final reqvalidator = RequiredValidator(errorText: 'This is a required field');

  final String jobTypeApi = 'https://www.alumni-cucek.ml/api/job/get/types/';

  List data = List();
  List deptData = List();
  Future<String> getJobType() async {
    var res = await http.get(jobTypeApi);
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    return "Sucess";
  }

  void initState() {
    super.initState();
    this.getJobType();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar('Create New Job Post'),
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
                            padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                            child: ReusableWidgets().customTextfield(
                              'Job Title',
                              jobTitleController,
                              Icon(Icons.work),
                              false,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: ReusableWidgets().customTextfield(
                              'Location',
                              locController,
                              Icon(Icons.location_city),
                              false,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: new DropdownButton(
                              dropdownColor: Colors.grey[200],
                              items: data.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(
                                    item['type'],
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
                                  jobType = newVal;
                                  print(jobType);
                                });
                              },
                              hint: Text('Choose Job Type'),
                              elevation: 20,
                              value: jobType,
                            ),
                          ),
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
                                  if (jobType != null) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .leftToRightWithFade,
                                        child: JobsCreate3(
                                          jobTitle: jobTitleController.text,
                                          location: locController.text,
                                          jobType: jobType,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
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
      ),
    );
  }
}
