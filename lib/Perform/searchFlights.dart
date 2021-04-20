import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:virtual_destination/Perform/Forced%20Mode/forcedFlights.dart';
import 'package:virtual_destination/Perform/searchCars.dart';
import 'package:virtual_destination/Perform/searchHotels.dart';
import 'package:virtual_destination/Search%20Flights/searchResult.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/home%20page/settings.dart';

String toField, fromField;

DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now().add(Duration(days: 3));

class srchFlights extends StatefulWidget {
  @override
  _srchFlightsState createState() => _srchFlightsState();
}

class _srchFlightsState extends State<srchFlights> {
  GlobalKey<AutoCompleteTextFieldState<String>> toKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> fromKey = new GlobalKey();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AutoCompleteTextField toSearch, fromSearch;

  _startDatePicker() async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1960, 1, 1),
        maxTime: DateTime(2050, 12, 31), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      setState(() {
        startDate = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
    // startDate = await showDatePicker(
    //       context: context,
    //       initialDate: new DateTime.now(),
    //       firstDate: new DateTime(1960),
    //       lastDate: new DateTime(2050),
    //     ) ??
    //     DateTime.now();
    // setState(() {});
  }

  _endDatePicker() async {
    // endDate = await showDatePicker(
    //         context: context,
    //         initialDate: DateTime.now().add(Duration(days: 3)),
    //         firstDate: DateTime(1960),
    //         lastDate: DateTime(2050)) ??
    //     DateTime.now().add(Duration(days: 3));
    // setState(() {});

    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: startDate,
        maxTime: DateTime(2050, 12, 31), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      setState(() {
        endDate = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List cities = snapshot.data['Cities'];
          List flights = snapshot.data['flights'];
          return (isForced)? forceFlight(Cities: cities,flights: flights,) : Container(
            width: size.width,
            height: size.height * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Search Flights",
                    style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Flying from",
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FromSearch(context, cities),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Flying to",
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: ToSearch(context, cities),
                ),
                Row(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Start Date"),
                          TextButton(
                              onPressed: _startDatePicker,
                              child: Container(
                                width: size.width * 0.4,
                                height: size.height * 0.07,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: kPrimaryLightColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                    child: Text(startDate
                                        .toIso8601String()
                                        .substring(0, 10))),
                              ),
                              style:
                                  TextButton.styleFrom(primary: kPrimaryColor)),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text("End Date"),
                          TextButton(
                              onPressed: _endDatePicker,
                              child: Container(
                                width: size.width * 0.4,
                                height: size.height * 0.07,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: kPrimaryLightColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                    child: Text(endDate
                                        .toIso8601String()
                                        .substring(0, 10))),
                              ),
                              style:
                                  TextButton.styleFrom(primary: kPrimaryColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                peopleCount(),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>resultPage()));
                    },
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(61, 23, 88, 1),
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.08),
                      child: Center(
                        child: Text(
                          "Search",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * 0.06),
                        ),
                      ),
                    ))
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: firestore.collection('lists').doc('airlines').get(),
    );
  }

  Widget ToSearch(BuildContext context, List airlines) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.06,
        width: size.width * 0.9,
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: toSearch = AutoCompleteTextField(
              decoration: InputDecoration(
                hintText: "To Destination",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              clearOnSubmit: false,
              itemSubmitted: (toStr) {
                setState(() {
                  toField = toStr;
                  print(toField);
                  toSearch.textField.controller.text = toStr;
                });
              },
              textInputAction: TextInputAction.search,
              key: toKey,
              suggestions: airlines,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    index,
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                );
              },
              itemSorter: (a, b) {
                return a.compareTo(b);
              },
              itemFilter: (item, query) {
                return item.toLowerCase().startsWith(query.toLowerCase());
              }),
        ));
  }

  Widget FromSearch(BuildContext context, List airlines) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
        child: fromSearch = AutoCompleteTextField(
            clearOnSubmit: false,
            decoration: InputDecoration(
              hintText: "From Destination",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            itemSubmitted: (toStr) {
              setState(() {
                  fromField = toStr;
                  print(fromField);
                  fromSearch.textField.controller.text = toStr;
              });
            },
            key: fromKey,
            suggestions: airlines,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Text(
                    index,
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                );
            },
            itemSorter: (a, b) {
              return a.compareTo(b);
            },
            itemFilter: (item, query) {
              return item.toLowerCase().startsWith(query.toLowerCase());
            }),
      ),
    );
  }
}

class peopleCount extends StatefulWidget {
  @override
  _peopleCountState createState() => _peopleCountState();
}

class _peopleCountState extends State<peopleCount> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.18,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  "Adults",
                  style: TextStyle(
                      fontSize: size.height * 0.024, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.all(11),
                height: size.height * 0.06,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: DropdownButton<int>(
                    onChanged: (e) {
                      setState(() {
                        adults = e;
                      });
                    },
                    value: adults,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 20,
                    style: TextStyle(
                      color: Color.fromRGBO(8, 34, 119, 1),
                    ),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map<DropdownMenuItem<int>>((int e) {
                      return DropdownMenuItem<int>(
                        value: e,
                        child: Text(e.toString()),
                      );
                    }).toList()),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  "Children",
                  style: TextStyle(
                      fontSize: size.height * 0.024, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.all(11),
                height: size.height * 0.06,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: DropdownButton<int>(
                    onChanged: (e) {
                      setState(() {
                        children = e;
                      });
                    },
                    value: children,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 20,
                    style: TextStyle(
                      color: Color.fromRGBO(8, 34, 119, 1),
                    ),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map<DropdownMenuItem<int>>((int e) {
                      return DropdownMenuItem<int>(
                        value: e,
                        child: Text(e.toString()),
                      );
                    }).toList()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
