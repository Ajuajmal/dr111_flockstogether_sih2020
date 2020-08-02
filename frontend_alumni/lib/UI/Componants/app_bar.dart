import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titleText;
  CustomAppBar(this.titleText) : preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
        backgroundColor: Color(0xff142850),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        title: Text(
          this.titleText,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
