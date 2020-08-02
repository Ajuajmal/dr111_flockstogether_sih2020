import 'package:alumni/UI/screens/jobs/Jobs3.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobsTwo extends StatefulWidget {
  final String name;
  final String email;
  final String contact;
  JobsTwo({this.name, this.email, this.contact});
  @override
  _JobsTwoState createState() => _JobsTwoState();
}

class _JobsTwoState extends State<JobsTwo> {
  final _formKey = GlobalKey<FormState>();
  final answersController = new TextEditingController();

  final qnController = new TextEditingController();
  final requiredValidator =
      RequiredValidator(errorText: 'This field is required');
  String qnFromApi = '';

  getQns() async {
    var response =
        await http.get('https://www.alumni-cucek.ml/api/get/job/1/detail/');
    var jsonData = json.decode(response.body);
    print(jsonData);
    if (response.statusCode == 200) {
      setState(() {
        qnFromApi = jsonData[0]['questions_to_applicants'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getQns();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String email = widget.email;
    String contact = widget.contact;
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Question From Employer:',
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                                  child: Text(
                                    qnFromApi,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextFormField(
                            controller: answersController,
                            validator: requiredValidator,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Answers To Employer',
                            ),
                            style:
                                TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            controller: qnController,
                            maxLines: 4,
                            validator: requiredValidator,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Questions To Employer',
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
                                textColor: Colors.white,
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Text('Next'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .leftToRightWithFade,
                                        child: JobsThree(
                                          name: name,
                                          email: email,
                                          contact: contact,
                                          qn: qnController.text,
                                          ans: answersController.text,
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
