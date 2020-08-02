import 'package:alumni/UI/screens/jobs/jobscreation/jobscreate2.dart';

import 'package:alumni/UI/screens/jobs/jobscreation/previousJobs.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class JobsCreate1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hire'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Previous Postings'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: MyPostings(),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('New Posting'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: JobsCreate2(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
