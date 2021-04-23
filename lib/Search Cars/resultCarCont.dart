import 'dart:io';

import 'package:flutter/material.dart';
import 'package:virtual_destination/Search%20Cars/bookingConfirmPage.dart';
import 'package:virtual_destination/Search%20Cars/searchResult.dart';
import 'package:virtual_destination/home%20page/settings.dart';

List<String> cars = [
  "Hyundai","Lamborghini","Toyota Corolla",
  "Chevy surburban","Bentley continental","Mitsubishi",
  "Porsche","Ford Focus","Range Rover",
  "VW golf"
];

class carContainer extends StatelessWidget {
  int no,price;
  String name,filePath;
  carContainer({this.no,this.price,this.name,this.filePath});
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
            child: (filePath==null)?Image.asset("assets/images/car$no.jpeg",
              fit: BoxFit.fill,):Image.file(File(filePath),fit: BoxFit.fill,),
          ),
          Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Padding(
               padding: const EdgeInsets.all(9.0),
               child: Text("${(name==null)?cars[no-1]:name}",style: TextStyle(
                 fontSize: size.width*0.045,
                 fontWeight: FontWeight.bold
               ),),
             ),
             Padding(
               padding: const EdgeInsets.all(9.0),
               child: Column(
                 children: [
                   Text("$currency ${(price==null)?carPrices[no-1]:price}",style: TextStyle(
                     fontSize: size.width*0.035
                   ),),
                   Text("Per day",style:TextStyle(
                     fontSize: size.width*0.035
                   ))
                 ],
               ),
             )
           ],
          ),
          Padding(
            padding: EdgeInsets.only(left:size.width*0.5),
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>confirmBooking(no: no,selectedCar: (name==null)?cars[no-1]:name,selectedCarPrice: (price==null)?carPrices[no-1]:price,filePath: filePath,)));
            },
            style: ButtonStyle(),
            child: Container(
              width: size.width*0.29,
              height: size.height*0.06,
              decoration: BoxDecoration(
               border: Border.all(color: Colors.black),
               borderRadius: BorderRadius.all(Radius.circular(14))
              ),
              child: Center(child: Text("Book",textAlign: TextAlign.center,style: TextStyle(
                fontSize: size.width*0.05,
               color: Colors.black54
              ),)))),
          )
        ],
      ),
    );
  }
}