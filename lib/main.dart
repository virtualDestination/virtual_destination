import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_destination/Network/cities.dart';
import 'package:virtual_destination/Notifications/push_notification_service.dart';
import 'package:virtual_destination/Perform/travelHomePage.dart';
import 'package:virtual_destination/home%20page/homePage.dart';
import 'package:virtual_destination/home%20page/settings.dart';
import 'package:virtual_destination/login/signIn.dart';
import 'package:http/http.dart' as http;

bool isLoggedIn = false;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: false,
    sound: false,
  );
  runApp(MyApp());
}

String flightReview = "The flights were exceptional.The seats and legroom was so comfortable and the on board refreshments were very nice.The location of the check in desk is very close to the duty free shops.The airline can also provide Accommodation close to the airport if your flight is early in the morning so you can stay the night before in the airport hotel and recharge before your flight.I would only use this airline again. ⭐ ⭐ ⭐ ⭐";

String hotelReview = "Great location, superb value.We received free refreshments on our arrival.The room was very nice and the bed was comfortable and the Accommodation was first class.Shops, bars, and places to dine out are within walking distance.The service was Exceptional You can relax and recharge here Can’t wait to return next year.⭐ ⭐ ⭐ ⭐";

String carReview = "The location of the car hire was just outside the arrival gate.The staff were exceptional and offered to carry our bags to the car.The car we choose was so comfortable and the drive to our accommodation was a pleasure to drive.We arrived early at our hotel and had free refreshments on arrival.⭐ ⭐ ⭐ ⭐";

String flightsAndHotelsReview = "We got a great package deal booking our flights and hotel at the same time.The price was exceptional.On board the flight we had great leg room and free refreshments.The accommodation was lovely and the bed was very comfortable.The location was close to the shops and bars.Can't wait to go back again.⭐ ⭐ ⭐ ⭐";
String androidToken;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<bool> isLogedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool('logIn');
    return isLoggedIn;
  }

  Future<bool> isPerformanceMode() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isPerformMode = sharedPreferences.getBool('performance');
    return isPerformMode;
  }

  Future<void> performanceMode(bool isPerform) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setBool('performance', isPerform);
      isPerformance = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.initDynamicLinks();
  }


  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            print("I am in On Link");
            performanceMode(true);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>performHome()));
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print("I am here");
      performanceMode(true);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>performHome()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: "OK",),
      home: FutureBuilder<bool>(
        builder: (context,snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            if(snapshot.data == true){
            return FutureBuilder<bool>(
              future: isPerformanceMode(),
                builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data==true){
                  return performHome();
                }else{
                  return homePage();
                }
              }else{
                return homePage();
              }
            });
          }else{
            return SignIn();
          }
          }else{
            return SignIn();
          }
      },future:  isLogedIn(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Cities> data;

  String serverToken = "AAAAa6wdiEw:APA91bHlVitbcfD3dLXTdQIUQqQExfAkiGBFmOxO3YmBZH4mpttVwsvDkCoY4Ldz1LDp7AxrDFrW9lwxPVZEouT8aPhRSKuuCy8RHSfKuy3HLJMiLb60Bo2tFOUY9he7HOss3IUTCIPL";
  int _counter = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    // TODO: implement initState
    // cityNetwork citynetwork = cityNetwork();
    // data = citynetwork.getCities();
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((value) => print("Message Received"));
  }

  void _incrementCounter() {
    // firestore.collection('lists').add({
    //         'Hotels':FieldValue.arrayUnion(hotels)
    //       }).then((value) => print("OK")).catchError((onError)=>print("Error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        // onPressed: (){
        //   FirebaseMessaging.instance.getToken().then((value){
        //     androidToken = value;
        //     print("Token: "+value.toString());
        //   });
        //   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,);
        //   // FirebaseMessaging.instance.
        // },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
