import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/rounded_button.dart';
import 'package:virtual_destination/Customize/rounded_input_field.dart';
import 'package:virtual_destination/Search%20Cars/resultCarCont.dart';
import 'package:virtual_destination/Search%20Flights/resultFlightsContainer.dart';
import 'package:virtual_destination/Search%20Hotels/resultHotelsContainer.dart';

  String forcedFromField, forcedToField, forcedHotelField, forcedCarField, forcedFlightField;

class forceMode extends StatefulWidget {
  @override
  _forceModeState createState() => _forceModeState();
}

class _forceModeState extends State<forceMode> {

  GlobalKey<AutoCompleteTextFieldState<String>> toKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> fromKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> hotelKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> carKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> flightKey = new GlobalKey();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 1,
        width: size.width,
        child: FutureBuilder(
          future: firestore.collection('lists').doc('airlines').get(),
          builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: RoundedInputField(
                    hintText: "From",
                    suggestions: snapshot.data['Cities'],
                    kEy: fromKey,
                    icon: Icons.home,
                    stringChanged: "from",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: RoundedInputField(
                    hintText: "To",
                    suggestions: snapshot.data['Cities'],
                    icon: Icons.home,
                    kEy: toKey,
                    stringChanged: "to",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: RoundedInputField(
                    hintText: "Hotel",
                    kEy: hotelKey,
                    suggestions: snapshot.data['Hotels'],
                    icon: Icons.home,
                    stringChanged: "hotel",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: RoundedInputField(
                    hintText: "Car",
                    kEy: carKey,
                    suggestions: snapshot.data['Cars'],
                    icon: Icons.home,
                    stringChanged: "car",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: RoundedInputField(
                    hintText: "Flights",
                    kEy: flightKey,
                    icon: Icons.home,
                    suggestions: snapshot.data['flights'],
                    stringChanged: "flight",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.24),
                  child: RoundedButton(
                    text: "Submit",
                    color: Colors.green,
                    press: () {
                      Navigator.pop(context);
                      print(forcedFromField+forcedToField+forcedHotelField+forcedCarField+forcedFlightField);
                    },
                  ),
                )
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
