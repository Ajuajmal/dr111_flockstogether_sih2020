import 'package:alumni/UI/Componants/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class JobsThree extends StatefulWidget {
  final String name;
  final String contact;
  final String email;
  final String qn;
  final String ans;
  JobsThree({this.name, this.contact, this.email, this.qn, this.ans});
  @override
  _JobsThreeState createState() => _JobsThreeState();
}

class _JobsThreeState extends State<JobsThree> {
  String filePath;
  File cv;

  bool _isLoading = false;
  applyJob(String filePath, String name, String contact, String email,
      String ans, String qn) async {
    print(filePath);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('token'));
    print(sharedPreferences.getInt('id'));

    var uri = Uri.parse('https://www.alumni-cucek.ml/api/job/apply/');
    print(name);
    print(ans);
    var req = http.MultipartRequest('POST', uri);
    req.files.add(await http.MultipartFile.fromPath('resume', filePath));
    req.fields['token'] = sharedPreferences.getString('token');
    req.fields['name'] = name;
    req.fields['applying_job'] = sharedPreferences.getInt('id').toString();
    req.fields['contact'] = contact;
    req.fields['email'] = email;
    req.fields['answers_to_employer'] = ans;
    req.fields['questions_to_employer'] = qn;

    var res = await req.send();
    print(res.reasonPhrase);
    print(res.statusCode);
    if (res.statusCode == 201) {
      setState(() {
        _isLoading = false;
      });
      _onAlertButtonPressed(context);
    } else {
      setState(() {
        _isLoading = false;
        _errorAlert(context);
      });
    }
  }

  Future getCvFile() async {
    File cv = await FilePicker.getFile();

    setState(() {
      filePath = cv.path;
      print(filePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String email = widget.email;
    String contact = widget.contact;
    String qn = widget.qn;
    String ans = widget.ans;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Jobs'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
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
                Container(
                  padding: EdgeInsets.fromLTRB(60, 120, 60, 0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colors.blueGrey,
                    child: Text('Upload CV'),
                    onPressed: getCvFile,
                  ),
                ),
                Container(
                  width: 380,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FlatButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text('Apply'),
                          onPressed: () {
                            applyJob(filePath, name, contact, email, ans, qn);
                            setState(
                              () {
                                _isLoading = true;
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Apply Job",
    desc: "The job application has been successfully submitted",
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

_errorAlert(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Apply Job",
    desc: "You have already applied for this job",
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
