import 'package:alumni/UI/Componants/app_bar.dart';
import 'package:alumni/UI/Componants/reusable_widgets.dart';
import 'package:alumni/UI/screens/jobs/joblisting.dart';
import 'package:alumni/UI/screens/jobs/jobscreation/JobsCreate1.dart';
import 'package:flutter/material.dart';

class JobsHireWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar('Work Or Hire'),
        body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 40, 15, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset('assets/images/work_hire.png'),
                ),
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(80, 50, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobListing(),
                              ),
                            );
                          },
                          child: ReusableWidgets()
                              .circleImage(context, 'assets/images/work.svg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                        child: Center(
                          child: Text(
                            'Work',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 50, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobsCreate1(),
                              ),
                            );
                          },
                          child: ReusableWidgets()
                              .circleImage(context, 'assets/images/hire.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Center(
                          child: Text(
                            'Hire',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
