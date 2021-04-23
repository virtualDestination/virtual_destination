import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Notifications/push_notification_service.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Search%20Flights/firstCont.dart';
import 'package:virtual_destination/Search%20Flights/resultFlightsContainer.dart';
import 'package:virtual_destination/Search%20Flights/secondCont.dart';
import 'package:virtual_destination/Search%20Flights/thirdCont.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/main.dart';

class confirmBooking extends StatefulWidget {
  String name,filePath;
  int no,price;
  confirmBooking({this.no,this.name,this.filePath,this.price});

  @override
  _confirmBookingState createState() => _confirmBookingState();
}

class _confirmBookingState extends State<confirmBooking> {
  int seats = 1,bags;
  String submit = "Check Out";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Text(""),
        flexibleSpace: Container(
          width: size.width * 0.8,
          height: size.height * 0.06,
          decoration: BoxDecoration(
              color: Color(0xFFdddddd),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.02,
              right: size.width * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.sort_by_alpha),
              Text("$addressUrl"),
              IconButton(icon: Icon(Icons.refresh), onPressed: (){
                if(isForced){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else{
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              })
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.bottomCenter,
              child: Text(
                "Checkout",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width * 0.095,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          firstContainer(no: (isForced)?2:widget.no,name: widget.name,),
          secondContainer(),
          thirdContainer(seats: seats,bags: bags,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.38,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Reviews",style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width*0.06,
                  ),),
                  Text("$flightReview",style: TextStyle(
                    color: Colors.black54,
                    fontSize: size.width*0.04,
                  ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.1,
              color: Colors.white,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: size.width,
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 6)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.03, right: 10, top: 12, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("Trip Total",
                        style: TextStyle(fontSize: size.width * 0.05)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "$currency ${(widget.price==null)?((isForced)?499:flightsPrices[widget.no-1]):widget.price}",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  sendingNoti noti = sendingNoti();
                  noti.sendNoti((isForced)?forcedFromField:fromField, (isForced)?forcedToField:toField, (isForced)?forcedFlightField:(widget.name==null)?airlines[widget.no-1]:widget.name,"Flight");
                  setState(() {
                    submit = "✔";
                    print("$submit");
                  });
                },
                child: Container(
                  width: size.width * 0.32,
                  height: size.height * 0.09,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Text(
                    submit,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.05),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// class bottomSheet extends StatefulWidget {
//   int no,price;
//   String name;
//
//   bottomSheet({this.no,this.price,this.name});
//
//   @override
//   _bottomSheetState createState() => _bottomSheetState();
// }
//
// class _bottomSheetState extends State<bottomSheet> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     Size size = MediaQuery.of(context).size;
//     return ;
//   }
// }
