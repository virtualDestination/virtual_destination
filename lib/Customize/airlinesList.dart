import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_destination/colors.dart';

class airlinesList extends StatefulWidget {
  @override
  _airlinesListState createState() => _airlinesListState();
}

class _airlinesListState extends State<airlinesList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String newAirline = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            // child: Image.asset(
            //   "assets/images/customise${0}.png",
            //   fit: BoxFit.fill,)
          ),
        Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          margin: EdgeInsets.only(bottom: size.height*0.01),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List _cities = snapshot.data['flights'];
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return itemCard(_cities[index], context);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: size.height * 0.02,
                    ),
                    itemCount: _cities.length);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: firestore.collection('lists').doc('airlines').get(),
          ),
        ),
        Positioned(
          bottom: size.height*0.09,
          right: 10,
          child: Container(
            child: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.add,),
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Form(
                      child: TextFormField(
                        initialValue: newAirline,
                        decoration: InputDecoration(
                          hintText: "Airline Name",
                        ),
                        onChanged: (airline){
                          setState(() {
                            newAirline = airline;
                          });
                        },
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        firestore.collection('lists').doc('airlines').update({
                        'flights': FieldValue.arrayUnion([newAirline])
                        }).then((value) => print("OK")).catchError((onError)=>print("Error"));
                        Navigator.pop(context);
                      }, child: Text("Ok"))
                    ],
                  );
                }).then((value){
                  
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget itemCard(String name, BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      // color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      padding:
      EdgeInsets.symmetric(horizontal: 15, vertical: size.height * 0.02),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.black54)),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$name",
            style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: kPrimaryLightColor,
              ),
              onPressed: () {
                firestore.collection('lists').doc('airlines').update({
                'flights': FieldValue.arrayRemove([name])
                }).then((value) => print("Succesfully Deleted Element"));
              })
        ],
      ),
    );
  }
}
