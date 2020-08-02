import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Jobs1.dart';

class JobDetailedView extends StatefulWidget {
  @override
  _JobDetailedView createState() => _JobDetailedView();
}

class _JobDetailedView extends State<JobDetailedView> {
  int id;
  String creator = '';
  String lastDate = '';
  String reqSkills = '';
  String jobName = '';
  String description = '';
  String jobType = '';
  String location = '';
  String workexpReq = '';
  String baseSalary = '';
  String companyName = '';
  bool _isLoading = false;

  preFetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getInt('id');
      print('detailed$id');
    });

    var response =
        await http.get('https://www.alumni-cucek.ml/api/get/job/$id/detail/');
    print(response.body);
    var jsonData = json.decode(response.body);
    setState(() {
      creator = jsonData[0]['creator'];
      lastDate = jsonData[0]['last_date'];
      reqSkills = jsonData[0]['req_skills'];
      jobName = jsonData[0]['job_name'];
      description = jsonData[0]['description'];
      jobType = jsonData[0]['job_type'];
      location = jsonData[0]['location'];
      workexpReq = jsonData[0]['workexp_req'];
      baseSalary = jsonData[0]['base_salary'];
      companyName = jsonData[0]['company_name'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    preFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Container(
//      color: Colors.grey[300],
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Center(
//                JOBNAME
                      child: Text(
                        jobName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
//                            Description
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Description',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 100,
                                                    maxWidth: 400,
                                                  ),
                                                  child: Container(
                                                    child: Text(
                                                      description,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),

//                            Company Name
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Company Name',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(companyName),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                            Last Date To Apply
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Last Date To Apply',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(lastDate),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                              Required Skills
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Required Skills',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(reqSkills),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                              Creator
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Creator',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(creator),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                              Job Type
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Job Type',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(jobType),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                              Location
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Location',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(location),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                              Work Experience Required
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Work Experience Required',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(workexpReq),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                              Base Salary
                                      Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Base Salary',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    fontFamily: 'OpenSans',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(baseSalary),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

//                            Apply Button
                                      Container(
                                          child: Center(
                                        child: FlatButton(
                                          color: Colors.blue,
                                          child: Text(
                                            'Apply',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => JobsOne(),
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
