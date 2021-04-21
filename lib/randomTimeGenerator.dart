import 'dart:math';

import 'package:virtual_destination/Perform/searchFlights.dart';

DateTime timeGenerator(){
  Random random = Random();
  DateTime randomTime = DateTime(startDate.year,startDate.month,startDate.day,random.nextInt(24),random.nextInt(60));
  return randomTime;
}