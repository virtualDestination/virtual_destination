import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:virtual_destination/Customize/rounded_decorative_input_field.dart';
import 'package:virtual_destination/Network/PODO.dart';
import 'package:virtual_destination/common%20components/rounded_button.dart';

// List<File> flightImages = <File>[];
// List<File> hotelImages = <File>[];
// List<File> carImages = <File>[];
//
// List<String> flightName = <String>[];
// List<String> hotelName = <String>[];
// List<String> carName = <String>[];
//
// List<int> createdFlightPrice = <int>[];
// List<int> createdHotelPrice = <int>[];
// List<int> createdCarPrice = <int>[];

ListOfCompanies list = new ListOfCompanies();


class createListing extends StatefulWidget {
  PageController pageController;
  createListing({this.pageController});
  @override
  _createListingState createState() => _createListingState();
}

class _createListingState extends State<createListing> {
  String typeOfTrip,tempName;
  int tempPrice;
  bool selectedImage = false;
  File selectImage;
  final LocalStorage storage = new LocalStorage('travel_app');

  _saveToStorage() {
    storage.setItem('createdLists', list.toJSONEncodable());
  }

  _addItem(String name, String typeOfTrip,int price,String filePath) {
    setState(() {
      final item = new createdComp(name: name,typeOfTrip: typeOfTrip,filePath: filePath,price: price);
      list.companies.add(item);
      _saveToStorage();
    });
  }

  Future<void> saveImage() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.any);
    if(result!=null){
      setState(() {
        selectImage = File(result.files.single.path);
        selectedImage = true;
      });
    }else{
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // storage.clear();
    return FutureBuilder(builder: (context,snapshot){
      if(snapshot.hasData){
        if(snapshot.data==true){
          return Container(
            height: size.height*0.75,
            width: size.width,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:size.width*0.35),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    // width: size.width*0.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(5.5, 6)
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    child: DropdownButton<String>(
                        onChanged: (e) {
                          setState(() {
                            typeOfTrip = e;
                          });
                        },
                        value: typeOfTrip,
                        icon: Icon(Icons.arrow_drop_down),
                        elevation: 20,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        items: <String>["Airline","Hotel","Car"].map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e.toString()),
                          );
                        }).toList()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.06,vertical: size.height*0.03),
                  child: RoundedInputField(
                    hintText: "Name",
                    onChanged: (str){
                      setState(() {
                        tempName = str;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.03),
                  child: Container(
                    height: size.height*0.25,
                    width: size.width*0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              blurRadius: 0.8,
                              spreadRadius: 0.9,
                              offset: Offset(5.5, 6)
                          )
                        ]
                    ),
                    child: GestureDetector(
                      onTap: saveImage,
                      child: (selectedImage)?Container(
                        child: Image.file(selectImage,fit: BoxFit.fill,),
                      ):Container(
                        height: size.height*0.25,
                        width: size.width*0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                child: Icon(Icons.camera_alt_outlined),
                                padding: EdgeInsets.all(8)
                            ),
                            Padding(
                                child: Text("Pick Image"),
                                padding: EdgeInsets.all(8)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.06,vertical: size.height*0.03),
                  child: RoundedInputField(
                    hintText: "Price",
                    onChanged: (str){
                      setState(() {
                        tempPrice = int.parse(str);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.2,vertical: size.height*0.025),
                  child: RoundedButton(
                    color: Colors.green,
                    text: "Add",
                    press: (){
                      if(tempName!=null && tempPrice!=null && tempName!=null && selectImage!=null){
                        _addItem(tempName, typeOfTrip, tempPrice, selectImage.path);
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    },
    future: storage.ready,
    );
  }
}


