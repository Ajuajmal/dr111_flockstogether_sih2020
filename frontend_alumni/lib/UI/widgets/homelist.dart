import 'package:flutter/material.dart';

class HomeList extends StatelessWidget {
  final String imageLoc;
  final String heading;
  final String desciption;
  HomeList({this.imageLoc, this.heading, this.desciption});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset(
                this.imageLoc,
                height: 100.0,
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        this.heading,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          this.desciption,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
