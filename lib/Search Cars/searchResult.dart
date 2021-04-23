
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:virtual_destination/Customize/createListing.dart';
import 'package:virtual_destination/Network/PODO.dart';
import 'package:virtual_destination/Perform/searchHotels.dart';
import 'package:virtual_destination/Search%20Cars/resultCarCont.dart';
import 'package:virtual_destination/home page/settings.dart';
import 'package:virtual_destination/Perform/searchFlights.dart';

List<int> carPrices = <int>[35,45,200,125,220,49,185,25,199,55];

class resultPage extends StatefulWidget {
  @override
  _resultPageState createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {
  LocalStorage storage = LocalStorage('travel_app');
  bool initialized = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Text(""),
        flexibleSpace: Container(
          width: size.width*0.8,
          height: size.height*0.06,
          decoration: BoxDecoration(
            color: Color(0xFFdddddd),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          margin: EdgeInsets.only(top: size.height*0.05,left: size.width*0.02,right: size.width*0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.sort_by_alpha),
              Text("$addressUrl"),
              IconButton(icon: Icon(Icons.refresh), onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: travelInfoContainer(),
            ),
            (isPreloaded)?ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                carContainer(no: 1),
                carContainer(no: 2),
                carContainer(no: 3),
                carContainer(no: 4),
                carContainer(no: 5),
                carContainer(no: 6),
                carContainer(no: 7),
                carContainer(no: 8),
                carContainer(no: 9),
                carContainer(no: 10),
              ],
            ):Text(""),
            FutureBuilder(
              future: storage.ready,
                builder: (context,snapshot){
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!initialized) {
                    var items = storage.getItem('createdLists');
                    print(items);

                    if (items != null) {
                      list.companies = List<createdComp>.from(
                        (items as List).map(
                              (item) => createdComp(
                              name: item['name'],
                              price: item['price'],
                              filePath: item['filePath'],
                              typeOfTrip: item['trip']
                          ),
                        ),
                      );
                    }
                    initialized = true;
                  }
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.companies.length,
                    itemBuilder: (context,index){
                      if(list.companies[index].typeOfTrip=="Car"){
                        return carContainer(price: list.companies[index].price,name: list.companies[index].name,filePath: list.companies[index].filePath,);
                      }else{
                        return Text("");
                      }
                    }
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            })
          ],
        ),
      ),
    );
  }
}

class travelInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.9,
      height: size.height*0.2,
      decoration: BoxDecoration(color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black.withOpacity(0.35),
        blurRadius: 10,spreadRadius: 6)
      ],
      borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: size.width*0.025,vertical: size.height*0.01),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Container(
           height: size.height*0.1,
           width: size.width*1,
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
               color: Colors.transparent,
               width: size.width*0.35,
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("$fromField",style: TextStyle(
                   color: Colors.black87,
                   fontSize: size.width*0.04
                  ),),
                  Text("${startDate.toString().substring(0,10)}",style: TextStyle(
                    color: Colors.black87
                  ),)
                ], 
               ),
              ),
              Icon(Icons.swap_horiz_outlined,color: Colors.black87,size: size.width*0.1,),
              Container(
               color: Colors.transparent,
               width: size.width*0.35,
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("$toField",style: TextStyle(
                   color: Colors.black87,
                   fontSize: size.width*0.04
                  ),),
                  Text("${endDate.toString().substring(0,10)}",style: TextStyle(
                    color: Colors.black87
                  ),)
                ], 
               ),
              ),
            ],
           ),
         ),
         Container(
          height: size.height*0.055,
          width: size.width*0.7,
          margin: EdgeInsets.only(left: size.width*0.08),
          child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Pick Up Time:",style: TextStyle(
                   fontSize: size.width*0.03,
                   color: Colors.black87
                 ),),
                 Text("${startDate.toString().substring(11,startDate.toString().length-7)}",style: TextStyle(
                   color: Colors.black87,
                   fontSize: size.width*0.048,
                   fontWeight: FontWeight.w500
                 ),),
               ],
             ),
             Padding(
               padding: EdgeInsets.only(top:size.height*0.02),
               child: Text(" - ",style: TextStyle(
                     color: Colors.black87,
                     fontSize: size.width*0.048,
                     fontWeight: FontWeight.w500
               ),),
             ),
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Drop Off Time:",style: TextStyle(
                   fontSize: size.width*0.03,
                   color: Colors.black87
                 ),),
                 Text("${endDate.toString().substring(11,startDate.toString().length-7)}",style: TextStyle(
                   color: Colors.black87,
                   fontSize: size.width*0.048,
                   fontWeight: FontWeight.w500
                 ),),
               ],
             ),
           ], 
          ),
         )
       ], 
      ),
    );
  }
}