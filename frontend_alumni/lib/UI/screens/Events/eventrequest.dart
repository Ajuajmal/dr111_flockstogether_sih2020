import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:alumni/UI/Componants/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

class EventRequest extends StatefulWidget {
  @override
  _EventRequestState createState() => _EventRequestState();
}

class _EventRequestState extends State<EventRequest> {
  final eventNameController = new TextEditingController();
  final descController = new TextEditingController();
  final specialController = new TextEditingController();
  final dateController = new TextEditingController();
  final locController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final reqValidator = RequiredValidator(errorText: 'This is a required field');
  final eventCreateApi = 'https://www.alumni-cucek.ml/api/event/create/';

  createEvent(String eventName, String description, String special,
      String location, String date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    Map data = {
      'event_name': eventName,
      'event_date': date,
      'description': description,
      'location': location,
      'special_req': special,
      'token': token,
    };

    var response = await http.post(eventCreateApi, body: data);
    var jsonData = json.decode(response.body);
    print(jsonData);

    if (response.statusCode == 201) {
      setState(() {
        _isLoading = false;
      });
      _onAlertButtonPressed(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Event Request'),
      ),
      body: SafeArea(
        child: Container(
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
                          'Create an Event',
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
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                              controller: eventNameController,
                              validator: reqValidator,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Event Name',
                              ),
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: "Roboto"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                              validator: reqValidator,
                              controller: descController,
                              maxLines: 3,
                              decoration: new InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Description',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                              validator: reqValidator,
                              controller: specialController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Special Requirements',
                              ),
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: "Roboto"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    width: 180,
                                    child: TextFormField(
                                      controller: locController,
                                      validator: reqValidator,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Venue',
                                      ),
                                      style: TextStyle(
                                          fontSize: 12.0, fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: TextFormField(
                                      controller: dateController,
                                      validator: reqValidator,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.calendar_today),
                                        labelText: 'Date',
                                      ),
                                      style: TextStyle(
                                          fontSize: 12.0, fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                              ],
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
                                        color: Colors.blue,
                                        child: Text('Request'),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            createEvent(
                                                eventNameController.text,
                                                descController.text,
                                                specialController.text,
                                                locController.text,
                                                dateController.text);
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
      ),
    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Event Request",
    desc: "Successfully created an event request",
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
