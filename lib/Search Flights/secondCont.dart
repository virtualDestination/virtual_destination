import 'package:flutter/material.dart';
import 'package:virtual_destination/home%20page/settings.dart';

class secondContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 6)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.025),
              child: Text(
                "Eco Light",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.035),
              child: Text(
                "Cabin: Economy",
                style: TextStyle(
                    color: Colors.black87, fontSize: size.width * 0.045),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.black87,
                      size: size.width * 0.05,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Text("Seat Choice",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: size.width * 0.05)),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.black87,
                      size: size.width * 0.05,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Text("Cancellation",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: size.width * 0.05)),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Icon(
                      Icons.check,
                      color: Colors.black87,
                      size: size.width * 0.05,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Text("Changes",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: size.width * 0.05)),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Icon(
                      Icons.check,
                      color: Colors.black87,
                      size: size.width * 0.05,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Text("Personal Items",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            fontSize: size.width * 0.05)),
                  )
                ],
              ),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: size.width,
              padding: EdgeInsets.all(size.width * 0.02),
              margin: EdgeInsets.all(10),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Carry On:",
                    style: TextStyle(color: Colors.black87),
                  ),
                  Text(
                    "Included",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "1st Checked Bag:",
                    style: TextStyle(color: Colors.black87),
                  ),
                  Text(
                    "$currency 13 upto 48 Kg",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "2nd Checked Bag:",
                    style: TextStyle(color: Colors.black87),
                  ),
                  Text(
                    "$currency 93 upto  Kg",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
