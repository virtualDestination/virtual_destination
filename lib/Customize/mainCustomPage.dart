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
  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(initialPage: 0);
    super.initState();
  }
  airlinesList airlineslist = airlinesList();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                airlineslist,
                listOfCities(),
                hotelsList(),
                carsList(),
                forceMode(),
                createListing(),
                createdLists()
              ],
              ),
            Positioned(
              bottom: 10,
              child: Container(
                width: size.width,
                height: size.height*0.08,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                    return listButton(titleList[index], index, context);
                },
                  itemCount: titleList.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listButton(String title,int pageNo,BuildContext context){
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        setState(() {
          pageController.jumpToPage(pageNo);
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        width: size.width*0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            color: (pageController.page==pageNo)?kPrimaryColor.withOpacity(0.5):Colors.white,
            boxShadow: [
              BoxShadow(
                  color: kPrimaryLightColor.withOpacity(1),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(5.5, 6)
              )]
        ),
        child: Text("$title",
          style: TextStyle(
              fontSize: size.width*0.04,
              letterSpacing: 1.5,
              color: (pageController.page==pageNo)?Colors.white:Colors.black
          ),textAlign: TextAlign.center,),
      ),
    );
  }
}
