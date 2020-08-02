import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FundRaiser extends StatefulWidget {
  @override
  _FundRaiserState createState() => _FundRaiserState();
}

class _FundRaiserState extends State<FundRaiser> {
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
          url: 'https://www.alumni-cucek.ml/fundraiser/$token/',
          hidden: true,
        ),
      ),
    );
  }
}
