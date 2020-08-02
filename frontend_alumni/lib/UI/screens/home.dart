import 'package:flutter/material.dart';
import '../widgets/homelist.dart';
import 'package:page_transition/page_transition.dart';
import 'package:alumni/UI/screens/Events/event.dart';
import 'jobs/work_hire.dart';
import 'package:alumni/UI/screens/Fundraiser/fundriser.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:alumni/UI/screens/Forum/forum.dart';
import 'package:alumni/UI/screens/Welcome_Screen/welcome_screen.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = '';
  final storage = new FlutterSecureStorage();

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Log Out",
      desc: "Do you want to Log Out?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              checkLoginStatus();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                  (Route<dynamic> route) => false);
            })
      ],
    ).show();
  }

  checkLoginStatus() async {
    await storage.delete(key: 'token');
  }

  preFetch() async {
    final String preFetachApi = 'https://www.alumni-cucek.ml/api/get/profile/';
    String token = await storage.read(key: 'token');
    print('current login token is $token');

    print(token);
    var response = await http.get(preFetachApi + token);
    print(response.body);
    var jsonData = json.decode(response.body);
    setState(() {
      username = jsonData['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    preFetch();
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        username,
        style: TextStyle(
            fontSize: 16, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        'anonymous@protonmail.ch',
        style: TextStyle(color: Colors.blue),
      ),
      currentAccountPicture: CircleAvatar(
        child: Image.network(
            'https://icons-for-free.com/iconfiles/png/512/facebook+profile+user+profile+icon-1320184041317225686.png'),
        backgroundColor: Colors.white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text(
            'Forum',
            style: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
          ),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: ForumWebView(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Jobs',
            style: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobsHireWork(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Events',
            style: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
          ),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: Event(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Fundraiser',
            style: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
          ),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: FundRaiser(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
          ),
          trailing: Icon(Icons.exit_to_app),
          onTap: () {
            _onAlertButtonsPressed(context);
          },
        ),
      ],
    );
    return Scaffold(
      drawer: Drawer(
        child: drawerItems,
      ),
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              Container(
                width: 380,
                height: 150,
                padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                color: Colors.blue[300],
                child: Center(
                  child: Text(
                    'CUCEK',
                    style: TextStyle(
                      letterSpacing: 3,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      HomeList(
                        desciption:
                            'B.Tech VIII Semester examiniation Time Table & U.O.(Online mode)  ',
                        imageLoc: 'assets/images/cucek.jpg',
                        heading: 'VIII Sem Exam',
                      ),
                      HomeList(
                        desciption:
                            'Strict vigilance in the wake of COVID19 spread all over the world - guidelines to students and staff',
                        imageLoc: 'assets/images/cucek.jpg',
                        heading: 'Alert',
                      ),
                      HomeList(
                        desciption:
                            'To familiarise the process of the examination, a model test shall be conducted for one of the subjects by the respective Head of the Division, latest by 25.06.2020.',
                        imageLoc: 'assets/images/cucek.jpg',
                        heading: 'Model Test',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
