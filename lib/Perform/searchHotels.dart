
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Perform/Forced%20Mode/forcedHotel.dart';
import 'package:virtual_destination/Search%20Hotels/bookingConfirmPage.dart';
import 'package:virtual_destination/Search%20Hotels/resultHotelsContainer.dart';
import 'package:virtual_destination/Search%20Hotels/searchResults.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/starsGenreator.dart';

int rooms = 1, adults = 1, children = 0;

class srchHotels extends StatefulWidget {
  @override
  _srchHotelsState createState() => _srchHotelsState();
}

class _srchHotelsState extends State<srchHotels> {
  GlobalKey<AutoCompleteTextFieldState<String>> toKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> fromKey = new GlobalKey();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AutoCompleteTextField toSearch, fromSearch;
  DateTime dateDiff = DateTime.now();

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
          List hotels = snapshot.data['Hotels'];
          return Container(
            width: size.width,
            height: size.height * 0.6,
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Search Hotels",
                    style: TextStyle(
                        fontSize: size.width * 0.06,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  height: size.height*0.2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Going to",
                          style: TextStyle(fontSize: size.width * 0.04),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:(isForced)? forcedHotelDropdown(hotels: hotels,): ToSearch(context, cities),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Check-In Date"),
                            TextButton(
                                onPressed: _startDatePicker,
                                child: Container(
                                  width: size.width * 0.4,
                                  height: size.height * 0.08,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                      child: Text(startDate
                                          .toIso8601String()
                                          .substring(0, 10))),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.black87)),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text("Check-Out Date"),
                            TextButton(
                                onPressed: _endDatePicker,
                                child: Container(
                                  width: size.width * 0.4,
                                  height: size.height * 0.08,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                      child: Text(endDate
                                          .toIso8601String()
                                          .substring(0, 10))),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.black87)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                peopleCount(),
                TextButton(onPressed: (){
                  (isForced)? Navigator.push(context, MaterialPageRoute(builder: (context)=>confirmBooking(no: hotelsList.indexOf(forcedHotelField)+1,stars: ratingSys(),))):
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>resultPage(nights: endDate.difference(startDate),)));
                }, child: Container(
                  width: size.width*0.8,
                  height: size.height*0.08,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(35))
                  ),
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.08),
                  child: Center(
                    child: Text("Search",textAlign: TextAlign.center,style: TextStyle(
                     color: Colors.white,
                     fontSize: size.width*0.06
                    ),),
                  ),
                )),
                (isForced)? tripContainer(3) :Text("")
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

  Widget tripContainer(int no){
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.29,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purpleAccent[400]),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      margin: EdgeInsets.symmetric(horizontal: size.width*0.06,vertical: size.height*0.0),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height*0.2,
            width: size.width,
            child: Image.asset("assets/images/bottomImage$no.jpeg",fit: BoxFit.fill,),
          ),
          TextButton(onPressed: (){}, child: Text("See Details"))
        ],
      ),
    );
  }

  Widget ToSearch(BuildContext context, List cities) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.056,
        width: size.width * 0.9,
        padding: EdgeInsets.only(bottom: size.height*0.002),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child:Center(
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
              suggestions: cities,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  "Rooms",
                  style:
                      TextStyle(fontSize: size.height * 0.024, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.all(11),
                height: size.height * 0.06,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: DropdownButton<int>(
                    onChanged: (e) {
                      setState(() {
                        rooms = e;
                      });
                    },
                    value: rooms,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 20,
                    style: TextStyle(
                      color: Colors.black87,
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
                  "Adults",
                  style:
                      TextStyle(fontSize: size.height * 0.024, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.all(11),
                height: size.height * 0.06,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black26,
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
                      color: Colors.black87,
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
                  style:
                      TextStyle(fontSize: size.height * 0.024, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.all(11),
                height: size.height * 0.06,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black26,
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
                      color: Colors.black87,
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
