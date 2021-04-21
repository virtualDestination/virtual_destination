import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/common%20components/rounded_button.dart';
import 'package:virtual_destination/common%20components/rounded_input_field.dart';
import 'package:virtual_destination/common%20components/rounded_password_field.dart';
import 'package:virtual_destination/home%20page/homePage.dart';
import 'package:virtual_destination/main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String Email,password;
  void setLogIn(bool value) async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool('logIn', value);
    print("Succesfully Logged In");
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height*0.1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("LOGIN",style: TextStyle(
                fontSize: size.height*0.04,
                fontWeight: FontWeight.w700,
                letterSpacing: 5,
                color: kPrimaryColor
              ),),
            ),
              SizedBox(height: size.height*0.03,),
              RoundedInputField(onChanged: (email){
                setState(() {
                  Email = email;
                });
              },hintText: "Email",),
            SizedBox(height: size.height*0.03,),
            RoundedPasswordField(onChanged: (pass){
              setState(() {
                password = pass;
              });
            },),
            Padding(
              padding: EdgeInsets.only(top:size.height*0.12),
              child: RoundedButton(text: "Login",color: kPrimaryColor,textColor: kPrimaryColor,press: (){
                  isLoggedIn = true;
                  setLogIn(true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homePage()));
              },),
            )
          ],
        ),
      ),
    );
  }
}
