import 'package:alumni/UI/Componants/reusable_widgets.dart';
import 'package:alumni/UI/screens/Registration/signup.dart';
import 'package:alumni/UI/screens/Registration/staff_signup.dart';
import 'package:alumni/UI/screens/Registration/studentsignup.dart';
import 'package:flutter/material.dart';

class SignUpSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 50, 60, 0),
              alignment: Alignment.center,
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Image.asset('assets/images/pablita-sign-in.png'),
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 100, 20, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentSignUp(),
                            ),
                          );
                        },
                        child: ReusableWidgets()
                            .circleImage(context, 'assets/images/student.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          'Student',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpForm(),
                          ),
                        );
                      },
                      child: ReusableWidgets()
                          .circleImage(context, 'assets/images/alumni.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        'Alumni',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaffReg(),
                              ),
                            );
                          },
                          child: ReusableWidgets().circleImage(
                              context, 'assets/images/faculty.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            'Staff',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
