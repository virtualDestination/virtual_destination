import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Notifications/push_notification_service.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Search%20Hotels/resultHotelsContainer.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/main.dart';

class confirmBooking extends StatelessWidget {
  int no,seats = 1,bags,price;
  String stars = "",filePath,name;
  confirmBooking({this.no,this.stars,this.price,this.name,this.filePath});
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
          Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(color: Colors.white),
            // alignment: Alignment.center,
            child: (isPreloaded)?Image.asset("assets/images/hotel$no.jpeg",fit: BoxFit.fill,):
                Image.file(File(filePath),fit: BoxFit.fill,)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${(isPreloaded)?hotelsList[no-1]:name}",style: TextStyle(
              color: Colors.black87,
              fontSize: size.width*0.08,
              fontWeight: FontWeight.w700
            ),),
          ),
          Padding(
            padding: EdgeInsets.all(size.width*0.04),
            child: Text("$stars",style: TextStyle(
              fontSize: size.width*0.05
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Amenities",style: TextStyle(
              color: Colors.black87,
              fontSize: size.width*0.05
            ),),
          ),
          Container(
            width: size.width,
            height: size.height*0.2,
            color: Colors.white,
            child: Image.network("https://i.dlpng.com/static/png/6918287_preview.png")),
          // firstContainer(no: no,),
          // secondContainer(),
          // thirdContainer(seats: seats,bags: bags,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.43,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Reviews",style: TextStyle(
                      color: Colors.black87,
                      fontSize: size.width*0.06,
                    ),),
                  ),
                  Text("$hotelReview",style: TextStyle(
                    color: Colors.black54,
                    fontSize: size.width*0.043,
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
                  child: Text("Per Day Price",
                      style: TextStyle(fontSize: size.width * 0.05)),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "$currency ${(isPreloaded)?hotelPrices[no-1]:price}",
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
                  noti.sendNoti("Hotel Stay", (isForced)?forcedToField:toField, (isForced)?forcedHotelField:(isPreloaded)?hotelsList[no-1]:name);
                },
                child: Container(
                  width: size.width * 0.32,
                  height: size.height * 0.09,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
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
