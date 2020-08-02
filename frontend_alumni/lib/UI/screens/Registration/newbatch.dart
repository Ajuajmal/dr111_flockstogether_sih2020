import 'package:alumni/UI/screens/Registration/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBatch extends StatefulWidget {
  @override
  _AddBatchState createState() => _AddBatchState();
}

class _AddBatchState extends State<AddBatch> {
  bool _isLoading = false;
  bool _dateError = false;
  bool _batchExists = false;
  final String addBatchApi =
      'https://www.alumni-cucek.ml//api/auth/account/create/batches/';

  addBatch(String sd, String ed) async {
    Map data = {
      'start': sd,
      'end': ed,
    };
    var response = await http.post(addBatchApi, body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      setState(() {
        showAlertDialog(context);
        _isLoading = false;
      });
    } else if (response.statusCode == 400) {
      setState(() {
        _isLoading = false;
      });
      if (jsonData['start'][0] == 'Your Batch Already Exists')
        setState(() {
          _batchExists = true;
        });
      if (jsonData['start'][0] ==
          'Date has wrong format. Use one of these formats instead: YYYY-MM-DD.')
        setState(() {
          _dateError = true;
        });
    }
  }

  String validateDate(String number) {
    if (number.length != 10) {
      return 'Date Format Error';
    }
    if (_batchExists) {
      _batchExists = false;
      return 'Batch already exists';
    }
    if (_dateError) {
      _batchExists = false;
      return 'Date Format is incorrect';
    } else
      return null;
  }

  final sdController = new TextEditingController();
  final edController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Batch'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              alignment: Alignment.center,
              child: Text(
                'Add New Batch',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Form(
                autovalidate: true,
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: 'Admission Date ',
                          helperStyle: TextStyle(
                              fontSize: 13,
                              fontFamily: 'OpenSans',
                              color: Colors.blueGrey),
                          labelText: 'yyyy-mm-dd',
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        validator: validateDate,
                        style: TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                        controller: sdController,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.date_range),
                            helperText: 'Pass Out Date ',
                            helperStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'OpenSans',
                                color: Colors.blueGrey),
                            labelText: 'yyyy-mm-dd',
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: validateDate,
                          style:
                              TextStyle(fontSize: 12.0, fontFamily: "Roboto"),
                          controller: edController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
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
                      child: Text('Done'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          addBatch(sdController.text, edController.text);
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
            builder: (BuildContext context) => SignUpForm(),
          ),
          (Route<dynamic> route) => false);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Add new batch"),
    content: Text("The batch has been added successfully"),
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
