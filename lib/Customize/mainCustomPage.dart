import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/City%20List.dart';
import 'package:virtual_destination/Customize/airlinesList.dart';
import 'package:virtual_destination/Customize/carsList.dart';
import 'package:virtual_destination/Customize/createListing.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/Customize/hotelList.dart';
import 'package:virtual_destination/Customize/liveListing.dart';
import 'package:virtual_destination/colors.dart';

class customise extends StatefulWidget {
  @override
  _customiseState createState() => _customiseState();
}

class _customiseState extends State<customise> {
  PageController pageController;
  bool isSelected = false;
  List<String> titleList = ["Flights","City","Hotels","Car","Force Mode","Create Listing","Live Listing",];
  List<Widget> listOfCustomize = [airlinesList(), listOfCities(), hotelsList(), carsList(), forceMode(), createListing(), createdLists()];
  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          Text("What Do You Want To Customize?",textAlign: TextAlign.center,)
        ],
      ),
      backgroundColor: Colors.black87,
      body: Container(
        width: size.width*1,
        height: size.height,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: size.width*0.12,right: size.width*0.12,top: size.height*0.1),
        child: ListView.builder(
         scrollDirection: Axis.vertical,
        itemBuilder: (context,index){
            return listButton(titleList[index], listOfCustomize[index], context,index);
        },
          itemCount: titleList.length,
        ),
      ),
    );
  }

  Widget listButton(String title,Widget routeTo,BuildContext context,int index){
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(child: routeTo)));
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.011),
        padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
        width: size.width*0.2,
        height: size.height*0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            color: (index>3)?Colors.transparent:Colors.green,
            border: Border.all(color: (index<4)?Colors.transparent:Colors.white)
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.white.withOpacity(1),
            //       blurRadius: 1,
            //       spreadRadius: 1,
            //       offset: Offset(5.5, 6)
            //   )]
        ),
        child: Text("$title",
          style: TextStyle(
              fontSize: size.width*0.04,
              letterSpacing: 1.5,
              color: Colors.white
          ),textAlign: TextAlign.center,),
      ),
    );
  }
}
