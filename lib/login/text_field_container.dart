import 'package:flutter/material.dart';
import 'package:virtual_destination/colors.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(
        //   width: 0.5
        // ),
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            color: kPrimaryLightColor.withOpacity(1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(5.5, 6)
          )
        ]
      ),
      child: child,
    );
  }
}