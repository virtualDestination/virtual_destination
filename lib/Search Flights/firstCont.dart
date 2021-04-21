import 'package:flutter/material.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';
import 'package:virtual_destination/Search%20Flights/resultFlightsContainer.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';

class firstContainer extends StatelessWidget {
  int no;
  String name;
  firstContainer({this.no,this.name});
  String from = "A Coruña";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      spreadRadius: 6)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(size.width*0.03),
                    margin: EdgeInsets.all(size.width*0.02),
                    width: size.width,
                    height: size.height*0.08,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width*0.02),
                          child: Container(
                            child: Text("${(isForced)? ((forcedToField!=null)?forcedToField:from) :((toField!=null)?toField.toUpperCase():toField)}",style: TextStyle(
                              color: Colors.black87,
                              fontSize: size.width*0.04,
                              fontWeight: FontWeight.w700,
                            ),overflow: TextOverflow.visible,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:size.height*0.01),
                          child: Text("from",style: TextStyle(
                            color: Colors.black87,
                            fontSize: size.width*0.05,
                            fontWeight: FontWeight.w300
                          ),),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(size.width*0.02),
                          child: Container(
                            child: Text("${(isForced)?((forcedFromField!=null)?forcedFromField:from):((fromField!=null)?fromField.toUpperCase():fromField)}",style: TextStyle(
                              color: Colors.black87,
                              fontSize: size.width*0.04,
                              fontWeight: FontWeight.w700
                            ),overflow: TextOverflow.visible,),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    width: size.width,
                    padding: EdgeInsets.all(size.width*0.02),
                    margin: EdgeInsets.all(10),
                  ),
                  Container(
                   width: size.width,
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         height: size.height*0.08,
                         padding: EdgeInsets.all(size.width*0.02),
                         child: Column(
                           children: [
                             Text("Departure",style: TextStyle(
                               color: Colors.black87
                             ),),
                             Text("${startDate.toString().substring(0,10)}",style: TextStyle(
                               color: Colors.white
                             ),)
                           ],
                         ),
                       ),
                       Container(
                         height: size.height*0.08,
                         padding: EdgeInsets.all(size.width*0.02),
                         child: Column(
                           children: [
                             Text("Returning",style: TextStyle(
                               color: Colors.black87
                             ),),
                             Text("${endDate.toString().substring(0,10)}",style: TextStyle(
                               color: Colors.black87
                             ),)
                           ],
                         ),
                       )
                     ],
                   ), 
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width*0.02),
                    child: Text("${(name==null)?((isForced)?forcedFlightField:airlines[no-1]):name}",style: TextStyle(
                      color: Colors.black87,
                      fontSize: size.width*0.04
                    ),),
                  )
                ],
              ),
            ),
          );
  }
}