import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtual_destination/Customize/mainCustomPage.dart';
import 'package:virtual_destination/Perform/travelHomePage.dart';
import 'package:virtual_destination/home%20page/readInstructions.dart';
import 'package:virtual_destination/home%20page/rounded_button.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/home%20page/videoTut.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String _url = "https://www.facebook.com/groups/315564823431585/";


  // void logOut(bool value) async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool('logIn', value);
  //   print("Succesfully Logged Out");
  // }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

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
              FocusedMenuItem(title: Text("Help"), onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    elevation: 8,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("If you have any questions about virtual destination please contact me by email. "),
                        TextButton(onPressed: (){_launchURL("mailto:Briankennedymagician@gmail.com");}, child: Text("Briankennedymagician@gmail.com"))
                      ],
                    ),
                  );
                });
              }),
              FocusedMenuItem(title: Text("About Virtual Destination"), onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    elevation: 10,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Created by Brian kennedy   App developed by ShellCode Solutions\n"),
                        Text("To share ideas and learn the latest tips and tricks with Virtual destination please join our closed"),
                        Text(""),
                        Container(width:124,child: TextButton(onPressed: (){_launchURL(_url);},child: Container(child: Row(
                          children: [
                            Text("F"),
                            Text("a"),
                            Text("c"),
                            Text("e"),
                            Text("b"),
                            Text("o"),
                            Text("o"),
                            Text("k"),
                            Text(" "),
                            Text("G"),
                            Text("r"),
                            Text("o"),
                            Text("u"),
                            Text("p")
                          ],
                        ),),))
                      ],
                    ),
                  );
                });
              }),
              FocusedMenuItem(title: Text("Read Instruction"), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Material(child: pdfViewer())));}),
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
