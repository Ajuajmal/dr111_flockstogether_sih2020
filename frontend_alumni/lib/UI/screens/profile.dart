import 'package:alumni/UI/screens/account.dart';
import 'package:alumni/UI/Componants/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:custom_switch/custom_switch.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  bool _private = false;
  String pri = 'False';
  final bioController = new TextEditingController();
  final workController = new TextEditingController();
  final fbController = new TextEditingController();
  final linkController = new TextEditingController();
  final skillCOntroller = new TextEditingController();
  final orgController = new TextEditingController();
  final twitterController = new TextEditingController();
  final skillController = new TextEditingController();
  bool _isLoading = false;
  File _image;
  String imgPath;
  final picker = ImagePicker();
  final String preFetachApi = 'https://www.alumni-cucek.ml/api/get/profile/';
  final String updateApi = 'https://www.alumni-cucek.ml/api/profile/update/';
  String imgUrl = '';

  preFetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    print(token);
    var response = await http.get(preFetachApi + token);
    print(response.body);
    var jsonData = json.decode(response.body);

    this.bioController.text = jsonData['bio'];
    this.skillController.text = jsonData['skills'];
    this.linkController.text = jsonData['linkedin'];
    this.fbController.text = jsonData['facebook'];
    this.workController.text = jsonData['work'];
    this.orgController.text = jsonData['organization'];
    this.twitterController.text = jsonData['twitter'];
    setState(() {
      imgUrl = jsonData['profile_pic'];
    });
  }

  updateProfile(
      String bio,
      String work,
      String org,
      String skills,
      String linkedin,
      String fb,
      String twitter,
      String filename,
      String pri) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var req = http.MultipartRequest('POST', Uri.parse(updateApi));
    req.files.add(await http.MultipartFile.fromPath('profile_pic', filename));
    req.fields['bio'] = bio;
    req.fields['skills'] = skills;
    req.fields['linkedin'] = linkedin;
    req.fields['facebook'] = fb;
    req.fields['work'] = work;
    req.fields['organization'] = org;
    req.fields['twitter'] = twitter;
    req.fields['token'] = token;
    req.fields['private'] = pri;

    var res = await req.send();
    print(res.reasonPhrase);
    print(res.statusCode);

    if (res.statusCode == 201) {
      setState(() {
        _isLoading = false;
        print('success');
        _onAlertButtonPressed(context);
      });
    } else {
      setState(() {
        _isLoading = false;
        print('failure');
      });
    }
  }

  updateProfileWithOutImage(String bio, String work, String org, String skills,
      String linkedin, String fb, String twitter, String pri) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var req = http.MultipartRequest('POST', Uri.parse(updateApi));
    req.fields['bio'] = bio;
    req.fields['skills'] = skills;
    req.fields['linkedin'] = linkedin;
    req.fields['facebook'] = fb;
    req.fields['work'] = work;
    req.fields['organization'] = org;
    req.fields['twitter'] = twitter;
    req.fields['token'] = token;
    req.fields['private'] = pri;

    var res = await req.send();
    print(res.reasonPhrase);
    print(res.statusCode);

    if (res.statusCode == 201) {
      setState(() {
        _isLoading = false;
        print('success');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AccountPage(),
            ),
            (route) => false);
      });
    } else {
      setState(() {
        _isLoading = false;
        print('failure');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    preFetch();
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      print(_image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 180,
              width: 180,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: Container(
                child: FlatButton(
                  child: Text(
                    'Change Profile Picture',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: getImageFromGallery,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bio',
                          ),
                          controller: bioController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Work',
                          ),
                          controller: workController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Organization',
                          ),
                          controller: orgController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Skills',
                          ),
                          controller: skillController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Linkedin',
                          ),
                          controller: linkController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Facebook',
                          ),
                          controller: fbController,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Twitter',
                          ),
                          controller: twitterController,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            height: 12.0,
                          ),
                          Text(
                            'Private Mode:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontFamily: 'OpenSans'),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: CustomSwitch(
                              activeColor: Colors.red,
                              value: _private,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  _private = value;
                                  if (_private == true) {
                                    pri = 'True';
                                  } else {
                                    pri = 'False';
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 400,
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  if (_image != null) {
                                    print('image selected');
                                    setState(() {
                                      _isLoading = true;
                                      imgPath = _image.path;
                                      updateProfile(
                                          bioController.text,
                                          workController.text,
                                          orgController.text,
                                          skillController.text,
                                          linkController.text,
                                          fbController.text,
                                          twitterController.text,
                                          imgPath,
                                          pri);
                                    });
                                  } else {
                                    print('image not selected');
                                    setState(() {
                                      _isLoading = true;
                                      updateProfileWithOutImage(
                                          bioController.text,
                                          workController.text,
                                          orgController.text,
                                          skillController.text,
                                          linkController.text,
                                          fbController.text,
                                          twitterController.text,
                                          pri);
                                    });
                                  }
                                },
                                textColor: Colors.white,
                                child: Text('Done'),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Profile Edit",
    desc: "Profile Updated Successfully",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarHome(),
            ),
            (route) => false),
        width: 120,
      )
    ],
  ).show();
}
