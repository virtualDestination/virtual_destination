import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_destination/colors.dart';

class carsList extends StatefulWidget {
  @override
  _carsListState createState() => _carsListState();
}

class _carsListState extends State<carsList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String newCar = "";
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
            //   "assets/images/customise${3}.png",
            //   fit: BoxFit.fill,)
              ),
        Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List _cities = snapshot.data['Cars'];
                return Container(
                  margin: EdgeInsets.only(bottom: size.height*0.01),
                  child: Scrollbar(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return itemCard(_cities[index], context);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: size.height * 0.02,
                        ),
                        itemCount: _cities.length),
                  ),
                );
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
              backgroundColor: Colors.green,
              child: Icon(Icons.add,),
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Form(
                      child: TextFormField(
                        initialValue: newCar,
                        decoration: InputDecoration(
                          hintText: "Car Name",
                        ),
                        onChanged: (car){
                          setState(() {
                            newCar = car;
                          });
                        },
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        }, child: TextButton(
                          child: Text("Ok"),
                          onPressed: (){
                            firestore.collection('lists').doc('airlines').update({
                            'Cars': FieldValue.arrayUnion([newCar])
                            }).then((value){
                              Navigator.pop(context);
                              print("OK");
                            }).catchError((onError)=>print("Error"));
                          },
                        ))
                    ],
                  );
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
          border: Border.fromBorderSide(BorderSide(color: Colors.black26)),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width*0.5,
            child: Text(
              "$name",
              style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.green,
              ),
              onPressed: () {
                firestore.collection('lists').doc('airlines').update({
                  'Cars': FieldValue.arrayRemove([name])
                }).then((value) => print("Succesfully Deleted Element"));
              })
        ],
      ),
    );
  }

}
