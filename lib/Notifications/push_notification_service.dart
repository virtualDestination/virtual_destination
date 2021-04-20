import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:virtual_destination/home%20page/settings.dart';

class sendingNoti{

  void sendNoti(String typeOfTrip,String destination,String service) async{
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
        "title": "Your $typeOfTrip",
        "body": "$typeOfTrip to $destination in $service."
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
}