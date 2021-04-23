import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
// import 'package:virtual_destination/Perform/Forced%20Mode/forcedCars.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Perform/searchHotels.dart';
import 'package:virtual_destination/Search%20Cars/resultCarCont.dart';
// import 'package:shellcode_internship/Search%20Flights/resultFlightsContainer.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/bookingConfirmPage.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/resultFlightsContainer.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/resultHotelsContainer.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/searchHotelResults.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/searchResult.dart';
import '../../colors.dart';

List<int> hotelPrices = <int>[99, 79, 59, 76, 85, 119, 199, 129, 220, 196];
List<int> flightsPrices = <int>[
  459,
  450,
  599,
  386,
  349,
  375,
  425,
  549,
  559,
  649
];
List<String> airlines = <String>[
  "American Airlines",
  "British Ailines",
  "Delta Airlines",
  "RyanAir",
  "Fly Emirates",
  "Etihad Airways",
  "EasyJet",
  "Lufthansa"
];

class forceFlightAndHotels extends StatefulWidget {
  List Cities, flights, hotels, cars;
  forceFlightAndHotels({this.Cities, this.flights, this.hotels, this.cars});
  @override
  _forceFlightAndHotelsState createState() => _forceFlightAndHotelsState();
}

class _forceFlightAndHotelsState extends State<forceFlightAndHotels> {
  String fromCity, toCity, flights, hotels, car;
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
              "Search Trips",
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
            height: size.height * 0.07,
            width: size.width * 1,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: DropdownButton(
              isExpanded: true,
                onChanged: (e) {
                  setState(() {
                    fromCity = forcedFromField;
                  });
                },
                value: fromCity,
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
            height: size.height * 0.07,
            width: size.width * 1,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: DropdownButton(
                isExpanded: true,
                onChanged: (e) {
                  setState(() {
                    toCity = forcedToField;
                  });
                },
                value: toCity,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text("Select Hotel"),
              ),
              Container(
                width: size.width * 1,
                margin: EdgeInsets.all(11),
                height: size.height * 0.07,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: DropdownButton(
                    isExpanded: true,
                    onChanged: (e) {
                      setState(() {
                        hotels = forcedHotelField;
                      });
                    },
                    value: hotels,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 20,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    items: widget.hotels.map<DropdownMenuItem>((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.toString()),
                      );
                    }).toList()),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text("Select Car"),
          ),
          Container(
            margin: EdgeInsets.all(11),
            height: size.height * 0.07,
            width: size.width * 1,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: DropdownButton(
              isExpanded: true,
                onChanged: (e) {
                  setState(() {
                    car = forcedCarField;
                  });
                },
                value: car,
                icon: Icon(Icons.arrow_drop_down),
                elevation: 20,
                style: TextStyle(
                  color: Colors.black87,
                ),
                underline: Container(
                  color: Colors.transparent,
                ),
                items: widget.cars.map<DropdownMenuItem>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  );
                }).toList()),
          ),
          forcedPeopleCount(
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
            child: Column(
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
          ),
          TextButton(
              onPressed: () {
                selectedHotelPrice = 125;
                selectedFlightPrice = 499;
                selectedAirline = forcedFlightField;
                selectedHotel = forcedHotelField;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            flight_and_hotels_booking_confirm()));
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

class forcedPeopleCount extends StatefulWidget {
  int bags, seats;
  forcedPeopleCount({this.bags, this.seats});
  @override
  _forcedPeopleCountState createState() => _forcedPeopleCountState();
}

class _forcedPeopleCountState extends State<forcedPeopleCount> {
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
