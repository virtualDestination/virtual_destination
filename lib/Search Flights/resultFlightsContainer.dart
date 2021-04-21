import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/airlinesList.dart';
import 'package:virtual_destination/Search%20Flights/bookingConfirmPage.dart';
import 'package:virtual_destination/home page/settings.dart';
import 'package:virtual_destination/randomTimeGenerator.dart';

List<int> flightsPrices = <int>[459,450,599,386,349,375,425,549,559,649];

List<String> airlines = <String>[
    "American Airlines","British Ailines","Delta Airlines",
    "RyanAir","Fly Emirates","Etihad Airways",
    "EasyJet","Lufthansa"
  ];

class flightContainer extends StatelessWidget {
  int no,price;
  String name,filePath;
  flightContainer({this.no,this.name,this.filePath,this.price});
  DateTime dateTime = timeGenerator();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height*0.02,horizontal: size.width*0.02),
      width: size.width,
      height: size.height*0.4,
      decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.all(Radius.circular(22)),
       boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black.withOpacity(0.15),
        blurRadius: 10,spreadRadius: 6)
      ],
      
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height*0.2,
            width: size.width,
            child: (filePath==null)?Image.asset("assets/images/airlines$no.jpeg",
            fit: BoxFit.fill,):Image.file(File(filePath),fit: BoxFit.fill,),
          ),
          Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: const EdgeInsets.all(9.0),
               child: Text("${(name==null)?airlines[no-1]:name}",style: TextStyle(
                 fontSize: size.width*0.045,
                 fontWeight: FontWeight.bold
               ),),
             ),
             Padding(
               padding: const EdgeInsets.all(9.0),
               child: Text("$currency ${(price==null)?flightsPrices[no-1]:price}",style: TextStyle(
                 fontSize: size.width*0.035
               ),),
             )
           ],
          ),
          Padding(
            padding: EdgeInsets.only(right:size.width*0.45,left: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Departure Timing",style: TextStyle(
                    fontSize: size.width*0.035
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${dateTime.toString().substring(11,dateTime.toString().length-7)}"),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:size.width*0.5),
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>confirmBooking(no: no,filePath: filePath,price: price,name: name,)));
            },
            style: ButtonStyle(),
            child: Container(
              width: size.width*0.29,
              height: size.height*0.06,
              decoration: BoxDecoration(
               border: Border.all(color: Colors.black54),
               borderRadius: BorderRadius.all(Radius.circular(14))
              ),
              child: Center(child: Text("Book",textAlign: TextAlign.center,style: TextStyle(
                fontSize: size.width*0.05,
               color: Colors.black87
              ),)))),
          )
        ],
      ),
    );
  }
} 