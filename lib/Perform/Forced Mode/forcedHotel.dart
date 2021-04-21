import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Search%20Hotels/resultHotelsContainer.dart';

import '../../colors.dart';

class forcedHotelDropdown extends StatefulWidget {
  List hotels;
  forcedHotelDropdown({this.hotels});
  @override
  _forcedHotelDropdownState createState() => _forcedHotelDropdownState();
}

class _forcedHotelDropdownState extends State<forcedHotelDropdown> {
  String hotel;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            width: size.width*0.4,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: DropdownButton(
                onChanged: (e) {
                  setState(() {
                    hotel = forcedHotelField;
                  });
                },
                value: hotel,
                icon: Icon(Icons.arrow_drop_down),
                elevation: 20,
                style: TextStyle(
                  color: Colors.black87,
                ),
                underline: Container(
                  color: Colors.transparent,
                ),
                items: hotelsList.map<DropdownMenuItem>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList()),
          );
  }
}