import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alumni/UI/screens/Welcome_Screen/welcome_screen.dart';

class ManualVerification extends StatefulWidget {
  @override
  _ManualVerificationState createState() => _ManualVerificationState();
}

class _ManualVerificationState extends State<ManualVerification> {
  File _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  manualVerify(String filename) async {
    print(filename);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('token'));

    var uri = Uri.parse(
        'https://www.alumni-cucek.ml/api/auth/account/verify/alumni/manuel/');
    var req = http.MultipartRequest('POST', uri);
    req.files
        .add(await http.MultipartFile.fromPath('verification_file', filename));
    req.fields['token'] = sharedPreferences.getString('token');
    var res = await req.send();
    print(res.reasonPhrase);
    print(res.statusCode);
    if (res.statusCode == 201) {
      setState(() {
        _isLoading = false;
      });

      _onAlertButtonPressed(context);
    } else if (res.statusCode == 400) {
      setState(() {
        _isLoading = false;
      });
      _errorMessage(context);
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      print(_image.path);
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
      print(_image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manual Verification'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(60, 250, 60, 0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              child: Text('Pick From Camera'),
              onPressed: getImageFromCamera,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              child: Text('Pick From Gallery'),
              onPressed: getImageFromGallery,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
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
                    child: Text('Verify'),
                    onPressed: () {
                      if (_image != null) {
                        setState(() {
                          _isLoading = true;
                        });
                        manualVerify(_image.path);
                      }
                    },
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
    title: "Manual Verification",
    desc: "The Proof has been submitted successfully",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false),
        width: 120,
      )
    ],
  ).show();
}

_errorMessage(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Manual Verification",
    desc: "You have already submitted the proof",
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false),
        width: 120,
      )
    ],
  ).show();
}
