import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Notifications/push_notification_service.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Perform/searchHotels.dart';
import 'package:virtual_destination/Search%20Hotels/resultHotelsContainer.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/main.dart';

class confirmBooking extends StatefulWidget {
  int no,price;
  String stars = "",filePath,name;
  confirmBooking({this.no,this.stars,this.price,this.name,this.filePath});

  @override
  _confirmBookingState createState() => _confirmBookingState();
}

class _confirmBookingState extends State<confirmBooking> {
  int seats = 1,bags;
  var submit = "Check Out";


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
          (isForced)?Text(""):Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(color: Colors.white),
            // alignment: Alignment.center,
            child: (widget.filePath==null)?(isForced)?Text(""):Image.asset("assets/images/hotel${widget.no}.jpeg",fit: BoxFit.fill,):
                Image.file(File(widget.filePath),fit: BoxFit.fill,)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${(widget.name==null)?(isForced)?forcedHotelField:hotelsList[widget.no-1]:widget.name}",style: TextStyle(
              color: Colors.black87,
              fontSize: size.width*0.08,
              fontWeight: FontWeight.w700
            ),),
          ),
          travelInfoContainer(nights: endDate.difference(startDate).inDays,),
          Padding(
            padding: EdgeInsets.all(size.width*0.04),
            child: Text("${widget.stars}",style: TextStyle(
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
                  Text("Reviews",style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width*0.06,
                  ),),
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
                    child: Text("Per Day Price",
                        style: TextStyle(fontSize: size.width * 0.05)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "$currency ${(widget.price==null)?((isForced)?125:hotelPrices[widget.no-1]):widget.price}",
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
                    noti.sendNoti((isForced)?forcedFromField:fromField, (isForced)?forcedToField:toField, (isForced)?forcedHotelField:(widget.name==null)?hotelsList[widget.no-1]:widget.name,"Hotel Stay");
                    setState(() {
                      submit = "✔";
                    });
                  },
                  child: Container(
                    width: size.width * 0.32,
                    height: size.height * 0.09,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      "$submit",
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * 0.05),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class travelInfoContainer extends StatelessWidget {
  int nights;
  travelInfoContainer({this.nights});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.9,
      height: size.height*0.25,
      decoration: BoxDecoration(color: Colors.white,
          // boxShadow: <BoxShadow>[
          //   BoxShadow(color: Colors.black.withOpacity(0.35),
          //       blurRadius: 10,spreadRadius: 6)
          // ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: size.width*0.025,vertical: size.height*0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: size.height*0.05,
            width: size.width*1,
            child: Container(
              color: Colors.transparent,
              width: size.width*0.35,
              child: Text("${(isForced)?forcedToField:toField}",style: TextStyle(
                  color: Colors.black87,
                  fontSize: size.width*0.059,
                  fontWeight: FontWeight.w700
              ),),
            ),
          ),
          Container(
            height: size.height*0.03,
            width: size.width*1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$nights Nights",style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width*0.048,
                    fontWeight: FontWeight.w500
                ),),
                Text("$rooms Rooms",style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width*0.048,
                    fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Container(
            height: size.height*0.03,
            width: size.width*1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$adults Adults",style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width*0.048,
                    fontWeight: FontWeight.w500
                ),),
                Text("$children Children",style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width*0.048,
                    fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:size.height*0.023),
            child: Text("Check In Time",style: TextStyle(
                color: Colors.black87.withOpacity(0.7)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${startDate.toString().substring(11,endDate.toString().length-10)}",style: TextStyle(
                color: Colors.black87
            ),),
          )
        ],
      ),
    );
  }
}
