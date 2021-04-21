import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:virtual_destination/Perform/Forced%20Mode/forcedCars.dart';
import 'package:virtual_destination/Search%20Cars/searchResult.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/home%20page/settings.dart';

// DateTime startDate = DateTime.now();
// DateTime endDate = DateTime.now().add(Duration(days: 3));

class srch_Hotels_Flights extends StatefulWidget {
  @override
  _srch_Hotels_FlightsState createState() => _srch_Hotels_FlightsState();
}

class _srch_Hotels_FlightsState extends State<srch_Hotels_Flights> {
  GlobalKey<AutoCompleteTextFieldState<String>> toKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> fromKey = new GlobalKey();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AutoCompleteTextField toSearch, fromSearch;

  _startDatePicker() async {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(1960, 1, 1),
        maxTime: DateTime(2050, 12, 31), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      setState(() {
        startDate = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  _endDatePicker() async {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: endDate,
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
          List Cities = snapshot.data['Cities'];
          List cars = snapshot.data['Cars'];
          return(isForced)? forceCars(cars: cars,Cities: Cities,): Container(
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
                    "Search Cars",
                    style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Picking from",
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FromSearch(context,Cities),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Dropping Off",
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ToSearch(context, Cities),
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
                                height: size.height * 0.08,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                    child: Text(startDate
                                            .toIso8601String()
                                            .substring(0, 10) +
                                        " at " +
                                        startDate.toString().substring(12,
                                            startDate.toString().length - 4))),
                              ),
                              style:
                                  TextButton.styleFrom(primary: Colors.black87)),
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
                                height: size.height * 0.08,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                    child: Text(endDate
                                            .toIso8601String()
                                            .substring(0, 10) +
                                        " at " +
                                        endDate.toString().substring(12,
                                            endDate.toString().length - 4))),
                              ),
                              style:
                                  TextButton.styleFrom(primary: Colors.black87)),
                        ],
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>resultPage()));
                    },
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.black87,
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
