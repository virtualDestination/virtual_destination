import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Perform/searchHotels.dart';
import 'package:virtual_destination/Search%20Flights/bookingConfirmPage.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/resultFlightsContainer.dart';
import '../../colors.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';

class forceFlight extends StatefulWidget {
  List Cities, flights;
  forceFlight({this.Cities, this.flights});
  @override
  _forceFlightState createState() => _forceFlightState();
}

class _forceFlightState extends State<forceFlight> {
  String fromCity, toCity, flights;
  int bags = 0, seats = 0;

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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              "Search Flights",
              style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              "Flying from",
              style: TextStyle(fontSize: size.width * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: DropdownButton(
                onChanged: (e) {
                  setState(() {
                    fromCity = forcedFromField;
                  });
                },
                value:fromCity,
                icon: Icon(Icons.arrow_drop_down),
                elevation: 20,
                style: TextStyle(
                  color: Colors.black87,
                ),
                underline: Container(
                  color: Colors.transparent,
                ),
                items: widget.Cities.map<DropdownMenuItem>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              "Flying To",
              style: TextStyle(fontSize: size.width * 0.04),
            ),
          ),
          Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: DropdownButton(
                onChanged: (e) {
                  setState(() {
                    toCity = forcedToField;
                  });
                },
                value:toCity,
                icon: Icon(Icons.arrow_drop_down),
                elevation: 20,
                style: TextStyle(
                  color: Colors.black87,
                ),
                underline: Container(
                  color: Colors.transparent,
                ),
                items: widget.Cities.map<DropdownMenuItem>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList()),
          ),
          peopleCount(
            bags: bags,
            seats: seats,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(startDate
                                  .toIso8601String()
                                  .substring(0, 10))),
                        ),
                        style: TextButton.styleFrom(primary: Colors.black87)),
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
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                              child: Text(
                                  endDate.toIso8601String().substring(0, 10))),
                        ),
                        style: TextButton.styleFrom(primary: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "No Of Seats",
                        style: TextStyle(
                            fontSize: size.height * 0.024, color: Colors.black),
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
                              seats = e;
                            });
                          },
                          value: seats,
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
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(
                        "Select Flight",
                        style: TextStyle(
                            fontSize: size.height * 0.024, color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(11),
                      height: size.height * 0.06,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: DropdownButton(
                          onChanged: (e) {
                            setState(() {
                              flights = forcedFlightField;
                            });
                          },
                          value:flights,
                          icon: Icon(Icons.arrow_drop_down),
                          elevation: 20,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          items: airlines.map<DropdownMenuItem>((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            );
                          }).toList()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => confirmBooking(no: airlines.indexOf((forcedFlightField!=null)?forcedFlightField:flights)+1,)));
              },
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
  }
}

class peopleCount extends StatefulWidget {
  int bags, seats;
  peopleCount({this.bags, this.seats});
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
                  style: TextStyle(
                      fontSize: size.height * 0.024, color: Colors.black),
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
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  "No Of Bags",
                  style: TextStyle(
                      fontSize: size.height * 0.024, color: Colors.black),
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
                        widget.bags = e;
                      });
                    },
                    value: widget.bags,
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
          ),
        ],
      ),
    );
  }
}
