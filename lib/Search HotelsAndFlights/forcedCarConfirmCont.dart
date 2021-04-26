import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';

class carCont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle normalText = TextStyle(
      color: Colors.black54,
      fontSize: size.width*0.045,
    );
    TextStyle highlightedText = TextStyle(
        color: Colors.black87,
        fontSize: size.width*0.053,
        fontWeight: FontWeight.w700
    );
    return Container(
      height: size.height * 0.5,
      width: size.width,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Car Selected ",
              style: normalText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "$forcedCarField",
              style: highlightedText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Pick-Up Time ",
              style: normalText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "3:00 P.M.",
              style: highlightedText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Drop-Off Time ",
              style: normalText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "12:00 P.M.",
              style: highlightedText,
            ),
          ),
        ],
      ),
    );
  }
}
