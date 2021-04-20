import 'package:flutter/material.dart';

class thirdContainer extends StatefulWidget {
  int seats,bags;
  thirdContainer({this.seats,this.bags});

  @override
  _thirdContainerState createState() => _thirdContainerState();
}

class _thirdContainerState extends State<thirdContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.321,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.1,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      spreadRadius: 6)
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Fare : Standard Economy",style: TextStyle(
                      color: Colors.black87,
                      fontSize: size.width*0.06,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text("Your Selection applies to this flight only",style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.width*0.04
                      ),),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.08,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No Of Seats",style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width*0.04,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      onChanged: (e) {
                        setState(() {
                          widget.seats = e;
                        });
                      },
                      value: widget.seats,
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 20,
                      style: TextStyle(
                        color: Color.fromRGBO(8, 34, 119, 1),
                      ),
                      underline: Container(
                        color: Colors.purpleAccent,
                      ),
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map<DropdownMenuItem<int>>((int e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: Text(e.toString()),
                        );
                      }).toList()),
                  )
                ],
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.08,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No Of Bags",style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width*0.04,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      onChanged: (e) {
                        setState(() {
                          widget.bags = e;
                        });
                      },
                      value: widget.bags,
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 20,
                      style: TextStyle(
                        color: Color.fromRGBO(8, 34, 119, 1),
                      ),
                      underline: Container(
                        color: Colors.purpleAccent,
                      ),
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map<DropdownMenuItem<int>>((int e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: Text(e.toString()),
                        );
                      }).toList()),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}