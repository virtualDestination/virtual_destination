import 'package:flutter/cupertino.dart';

class createdComp{
  String name,filePath,typeOfTrip;
  int price;

  createdComp({@required this.name,@required this.filePath,@required this.price,@required this.typeOfTrip});

  toJSONEncodable(){
    Map<String,dynamic> map = new Map();

    map['name'] = name;
    map['filePath'] = filePath;
    map['price'] = price;
    map['trip'] = typeOfTrip;

    return map;
  }
}

class ListOfCompanies{
  List<createdComp> companies = <createdComp>[];

  toJSONEncodable(){
    return companies.map((e){
      return e.toJSONEncodable();
    }).toList();
  }
}