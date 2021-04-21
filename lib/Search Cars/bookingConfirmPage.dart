import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Notifications/push_notification_service.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Search%20Cars/resultCarCont.dart';
import 'package:virtual_destination/Search%20Cars/searchResult.dart';
import 'package:virtual_destination/Search%20Hotels/resultHotelsContainer.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/main.dart';

class confirmBooking extends StatelessWidget {
  int no,seats = 1,bags;
  String selectedCar,filePath;
  int selectedCarPrice;
  String stars = "";
  confirmBooking({this.no,this.stars,this.selectedCar,this.selectedCarPrice,this.filePath});
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
            child: (filePath==null)?Image.asset("assets/images/car$no.jpeg",fit: BoxFit.fill,):Image.file(File(filePath),fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${(isForced)?forcedCarField:selectedCar}",style: TextStyle(
              color: Colors.black87,
              fontSize: size.width*0.08,
              fontWeight: FontWeight.w700
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Pickup Time",style: TextStyle(
              color: Colors.black54,
                fontSize: size.width*0.045,
                fontWeight: FontWeight.w700
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${startDate.toString().substring(0,10)} ${startDate.toString().substring(11,startDate.toString().length-7)}"
            ,style: TextStyle(
              color: Colors.black87,
                  fontSize: size.width*0.047,
                  fontWeight: FontWeight.w500
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Drop Off Time",style: TextStyle(
              color: Colors.black54,
                fontSize: size.width*0.045,
                fontWeight: FontWeight.w700
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${endDate.toString().substring(0,10)} ${endDate.toString().substring(11,startDate.toString().length-7)}"
            ,style: TextStyle(
              color: Colors.black87,
                  fontSize: size.width*0.047,
                  fontWeight: FontWeight.w500
            ),),
          ),
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
                      color: Colors.black,
                      fontSize: size.width*0.06,
                    ),),
                  ),
                  Text("$carReview",style: TextStyle(
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
      bottomSheet: bottomSheet(carPrice: selectedCarPrice,selectedCar: selectedCar,),
    );
  }
}

class bottomSheet extends StatelessWidget {
  int no;
  int carPrice;
  String selectedCar;
  bottomSheet({this.no,this.carPrice,this.selectedCar});
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
                  child: Text("Per Day",
                      style: TextStyle(fontSize: size.width * 0.05)),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "$currency ${(isForced)?75:carPrice}",
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
                  noti.sendNoti("Car Trip",
                      (isForced)?forcedToField:toField, (isForced)?forcedCarField:selectedCar);
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
