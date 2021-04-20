import 'package:flutter/material.dart';
import 'package:virtual_destination/colors.dart';

class topBar extends StatefulWidget {
  final PageController pageController;
  topBar({@required this.pageController});
  @override
  _topBarState createState() => _topBarState();
}

class _topBarState extends State<topBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                widget.pageController.jumpToPage(0);
              });
            },
            child: Container(
              width: size.width * 0.2,
              height: size.height * 0.1,
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.flight), Text("Flights")],
              ),
            ),
            style: TextButton.styleFrom(primary: kPrimaryColor)),
        TextButton(
            onPressed: () {
              setState(() {
                widget.pageController.jumpToPage(1);
              });
            },
            child: Container(
              width: size.width * 0.2,
              height: size.height * 0.1,
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.hotel), Text("Hotel")],
              ),
            ),
            style: TextButton.styleFrom(primary: kPrimaryColor)),
        TextButton(
            onPressed: () {
              setState(() {
                widget.pageController.jumpToPage(2);
              });
            },
            child: Container(
              width: size.width * 0.2,
              height: size.height * 0.1,
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [Icon(Icons.flight), Icon(Icons.hotel)],
                  ),
                  Text("Hotel+\nFlights")
                ],
              ),
            ),
            style: TextButton.styleFrom(primary: kPrimaryColor)),
        TextButton(
            onPressed: () {
              setState(() {
                widget.pageController.jumpToPage(3);
              });
            },
            child: Container(
              width: size.width * 0.2,
              height: size.height * 0.1,
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.directions_car), Text("Car")],
              ),
            ),
            style: TextButton.styleFrom(primary: kPrimaryColor))
      ],
    );
  }
}
