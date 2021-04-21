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

class confirmBooking extends StatelessWidget {
  int no,seats = 1,bags,price;
  String name,filePath;
  confirmBooking({this.no,this.name,this.filePath,this.price});
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
          firstContainer(no: no,name: name,),
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
      bottomSheet: bottomSheet(no: no,price: price,name: name,),
    );
  }
}

class bottomSheet extends StatelessWidget {
  int no,price;
  String name;
  bottomSheet({this.no,this.price,this.name});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                    "$currency ${(price==null)?flightsPrices[no-1]:price}",
                    style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  sendingNoti noti = sendingNoti();
                  noti.sendNoti("Flight", (isForced)?forcedToField:toField, (isForced)?forcedFlightField:(name==null)?airlines[no-1]:name);
                },
                child: Container(
                  width: size.width * 0.32,
                  height: size.height * 0.09,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.05),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
