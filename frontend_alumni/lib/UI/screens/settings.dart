import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './profile.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.person,
                size: 200,
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Mr.Anonymous',
                  textScaleFactor: 1.5,
                ),
                subtitle: Text('San Francisco'),
                trailing: Container(
                  color: Colors.blue,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    },
                    child: Text('Edit'),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        print('Notifications');
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications,
                          color: Colors.blue,
                        ),
                        title: Text('Notifications'),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        print('General');
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                        title: Text('General'),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        print('Account');
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        title: Text('Account'),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        print('Privacy');
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.security,
                          color: Colors.blue,
                        ),
                        title: Text('Privacy'),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        print('Block');
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.block,
                          color: Colors.blue,
                        ),
                        title: Text('Block'),
                      ),
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
