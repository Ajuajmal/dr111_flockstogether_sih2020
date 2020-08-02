import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumWebView extends StatefulWidget {
  @override
  _ForumWebViewState createState() => _ForumWebViewState();
}

class _ForumWebViewState extends State<ForumWebView> {
  String token;

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString('token');
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SafeArea(
        top: true,
        child: WebviewScaffold(
          url: 'https://www.alumni-cucek.ml/community/$token/',
          hidden: true,
          withLocalStorage: true,
        ),
      ),
    );
  }
}
