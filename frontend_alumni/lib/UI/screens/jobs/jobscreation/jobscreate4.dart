import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:alumni/UI/Componants/bottombar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobsCreate4 extends StatefulWidget {
  final String jobTitle;
  final String location;
  final String jobType;
  final String companyName;
  final String salary;
  final String lastDate;

  JobsCreate4(
      {this.jobTitle,
      this.location,
      this.jobType,
      this.companyName,
      this.salary,
      this.lastDate});

  @override
  _JobsCreate4State createState() => _JobsCreate4State();
}

class _JobsCreate4State extends State<JobsCreate4> {
  final _formKey = GlobalKey<FormState>();
  final skillsController = new TextEditingController();
  final workExpController = new TextEditingController();
  final jobDesController = new TextEditingController();
  final qnsController = new TextEditingController();
  final reqvalidator = RequiredValidator(errorText: 'This is a required field');
  bool _isLoading = false;
  final String jobCreateApi = 'https://www.alumni-cucek.ml/api/job/create/';
  createNewJob(
      String jobname,
      String compname,
      String description,
      String jobtype,
      String location,
      String exp,
      String salary,
      String qns,
      String lastdate,
      String skills) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    Map data = {
      "job_name": jobname,
      "company_name": compname,
      "description": description,
      "job_type": jobtype,
      "location": location,
      "workexp_req": exp,
      "base_salary": salary,
      "questions_to_applicants": qns,
      "last_date": lastdate,
      "req_skills": skills,
      "token": token,
    };

    var response = await http.post(jobCreateApi, body: data);
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
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String lastDate = widget.lastDate;
    String jobType = widget.jobType;
    String jobTitle = widget.jobTitle;
    String salary = widget.salary;
    String companyName = widget.companyName;
    String location = widget.location;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[100],
                            blurRadius: 20.0,
                            offset: Offset(0, 5),
                          )
                        ],
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[100]),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextFormField(
                        controller: workExpController,
                        validator: reqvalidator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          labelText: 'Work Experience',
                        ),
                        style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: jobDesController,
                        validator: reqvalidator,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          labelText: 'Job Descripition',
                        ),
                        style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: qnsController,
                        validator: reqvalidator,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          labelText: 'Questions to applicants',
                        ),
                        style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: skillsController,
                        validator: reqvalidator,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          labelText: 'Preferred Skills',
                        ),
                        style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 60,
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : FlatButton(
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  color: Colors.blue,
                                  child: Text('Create'),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      createNewJob(
                                          jobTitle,
                                          companyName,
                                          jobDesController.text,
                                          jobType,
                                          location,
                                          workExpController.text,
                                          salary,
                                          qnsController.text,
                                          lastDate,
                                          skillsController.text);
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
      ),
    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Job Creation",
    desc: "A new Job has been created successfully",
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
