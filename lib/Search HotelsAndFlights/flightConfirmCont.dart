import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Perform/searchHotels.dart';
import 'package:virtual_destination/Search%20HotelsAndFlights/searchResult.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/Search Flights/resultFlightsContainer.dart';
import 'package:virtual_destination/Search HotelsAndFlights/resultFlightsContainer.dart';

class flightBookingConfirmContainer extends StatefulWidget {
  @override
  _flightBookingConfirmContainerState createState() => _flightBookingConfirmContainerState();
}

class _flightBookingConfirmContainerState extends State<flightBookingConfirmContainer> {
  Color textColor = Colors.black;
  int seats=1,bags=1;
  Duration nights = endDate.difference(startDate);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.5,
      width: size.width,
      margin: EdgeInsets.all(15),
      // decoration: BoxDecoration(color: Colors.black),
      padding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.width*0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Flying From ",style: TextStyle(
                  color: Colors.black54,
                  fontSize: size.width*0.045,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("${(isForced)?forcedFromField:fromField}",style: TextStyle(
                  color: Colors.black87,
                  fontSize: size.width*0.052,
                  fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Flight",style: TextStyle(
              color: Colors.black54,
              fontSize: size.width*0.042
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("$selectedAirline",style: TextStyle(
              color: Colors.black87,
              fontSize: size.width*0.056,
              fontWeight: FontWeight.bold
            ),),
          ),
          Text("Depature",style: TextStyle(
            color: Colors.black54,
            fontSize: size.width*0.042
          ),),
          Text("${startDate.toString().substring(0,10)} - ${startDate.toString().substring(11,startDate.toString().length-10)}",style: TextStyle(
            color: Colors.black87,
            fontSize: size.width*0.056,
            fontWeight: FontWeight.bold
          ),),
          Text("Price",style: TextStyle(
            color: Colors.black54,
            fontSize: size.width*0.045,
          ),),
          Text("$currency $selectedFlightPrice",style: TextStyle(
            color: Colors.black87,
            fontSize: size.width*0.052,
            fontWeight: FontWeight.bold
          ),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${nights.inDays} Days  $adults Adults  $children Children",style: TextStyle(
              color: Colors.black87,
              fontSize: size.width*0.045,
            ),),
          ),
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No Of Seats",style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width*0.04,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        color: Color.fromRGBO(8, 34, 119, 1),
                      ),
                      underline: Container(
                        color: Colors.purpleAccent,
                      ),
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map<DropdownMenuItem<int>>((int e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: Text(e.toString()),
                        );
                      }).toList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No Of Bags",style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width*0.04,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      onChanged: (e) {
                        setState(() {
                          bags = e;
                        });
                      },
                      value: bags,
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 20,
                      style: TextStyle(
                        color: Color.fromRGBO(8, 34, 119, 1),
                      ),
                      underline: Container(
                        color: Colors.purpleAccent,
                      ),
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map<DropdownMenuItem<int>>((int e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: Text(e.toString()),
                        );
                      }).toList()),
                  )
                ],
              ),
        ],
      ),
    );
  }
}