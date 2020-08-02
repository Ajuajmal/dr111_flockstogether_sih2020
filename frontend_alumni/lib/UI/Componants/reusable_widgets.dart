import 'package:alumni/utilitis/screensize.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ReusableWidgets {
  ScreenSize screenSize;
  final reqValidator = RequiredValidator(errorText: 'This is a required field');

  Widget circleImage(BuildContext context, String image) {
    screenSize = ScreenSize().getSize(context);
    return Card(
      elevation: 25,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: CircleAvatar(
        radius: screenSize.width / 8,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(image),
      ),
    );
  }

  Widget customTextfield(
    String hintText,
    TextEditingController controller,
    Icon icon,
    bool secureText,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 20.0,
            offset: Offset(0, 5),
          )
        ],
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]),
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: secureText,
        validator: reqValidator,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
