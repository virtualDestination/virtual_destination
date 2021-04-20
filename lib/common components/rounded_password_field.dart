import 'package:flutter/material.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/common%20components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (pwValue) {
          if (pwValue.isEmpty) {
            return 'This field is mandatory';
          }
          if (pwValue.length < 8) {
            return 'Password must be at least 8 characters';
          }

          return null;
        },
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}