import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_destination/Customize/mainCustomPage.dart';
import 'package:virtual_destination/Perform/travelHomePage.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/home%20page/rounded_button.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/home%20page/videoTut.dart';
import 'package:virtual_destination/login/signIn.dart';
import 'package:virtual_destination/main.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  void logOut(bool value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('logIn', value);
    print("Succesfully Logged Out");
  }

  void sendNoti() async{
    var token = await FirebaseMessaging.instance.getToken();

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization':"key=AAAAa6wdiEw:APA91bHlVitbcfD3dLXTdQIUQqQExfAkiGBFmOxO3YmBZH4mpttVwsvDkCoY4Ldz1LDp7AxrDFrW9lwxPVZEouT8aPhRSKuuCy8RHSfKuy3HLJMiLb60Bo2tFOUY9he7HOss3IUTCIPL"
    };


    var bodyPal = {
      "to": "/topics/travel",
      "data": {
        "clickaction": "FLUTTERNOTIFICATIONCLICK",
        "id": "1",
        "status": "done"
      },
      "priority": "high",
      "notification": {
        "body": "Your trip to hello World",
        "title": "typeOfTrip to in service."
      },
    };

    Future.delayed(Duration(seconds: countdown),() async {
      Response response = await Dio().post(
        "https://fcm.googleapis.com/fcm/send",
        options: Options(
            headers: headers,
            followRedirects: false,
            contentType: 'application/json'
        ),
        data: bodyPal,
      );
      print(response.data.toString());
    });


    // FirebaseMessaging.instance.sendMessage(
    //   to: androidToken,
    //     data: <String,String>{
    //   "title":"Hello World",
    //   "body":"App Message"
    // }).then((value) => print("Sent Message"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.subscribeToTopic("travel").then((value) => print("Successfully Subscribed to topic"));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print(message.toString());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          title: Text("Virtual Destination",style: TextStyle(
            color: Colors.white,
            fontSize: size.height*0.0278,
          ),),
          centerTitle: true,
          leading: FocusedMenuHolder(child: Icon(Icons.info),onPressed: (){},
            menuItems: [
              FocusedMenuItem(title: Text("Help"), onPressed: (){}),
              FocusedMenuItem(title: Text("About Virtual Destination"), onPressed: (){}),
              FocusedMenuItem(title: Text("Read Instruction"), onPressed: (){}),
              FocusedMenuItem(title: Text("Log Out"), onPressed: (){
                isLoggedIn = false;
                logOut(false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));
              })
            ],),
          actions: [
            IconButton(icon: Icon(Icons.settings), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>settings()));
            })
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: Colors.black87,
                child: Image.asset("assets/images/homePage.png",fit: BoxFit.fill,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left:size.width*0.1),
                      child: RoundedButton(text: "Video Tutorial",textColor: Colors.white,color: Colors.green,press: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ytVidPlayer()));
                      },)),
                  Padding(
                      padding: EdgeInsets.only(left:size.width*0.1),
                      child: RoundedButton(text: "Customise",textColor: Colors.white,color: Colors.green,press: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>customise()));
                      },)),
                  Padding(
                      padding: EdgeInsets.only(left:size.width*0.1),
                      child: RoundedButton(text: "Perform",textColor: Colors.white,color: Colors.green,press: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>performHome()));
                      },))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
