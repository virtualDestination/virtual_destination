// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:virtual_destination/Customize/createListing.dart';
import 'package:virtual_destination/Network/PODO.dart';

class createdLists extends StatefulWidget {
  @override
  _createdListsState createState() => _createdListsState();
}

class _createdListsState extends State<createdLists> {
  final LocalStorage storage = new LocalStorage('travel_app');
  bool initialized = false;
  _saveToStorage() {
    storage.setItem('createdLists', list.toJSONEncodable());
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context,snapshot){
      if (snapshot.data == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!initialized) {
        var items = storage.getItem('createdLists');
        print(items);

        if (items != null) {
          list.companies = List<createdComp>.from(
            (items as List).map(
                  (item) => createdComp(
                    name: item['name'],
                    price: item['price'],
                    filePath: item['filePath'],
                    typeOfTrip: item['trip']
              ),
            ),
          );
        }
        initialized = true;
      }

      List<Widget> widgets = list.companies.reversed.toList().map((item) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 20,
            shadowColor: Colors.white,
            child: ListTile(
              leading: Container(
                width: 100,
                  height: 120,
                  child: Image.file(File(item.filePath),fit: BoxFit.fill,)),
              title: Text(item.name),
              subtitle: Text(item.price.toString()),
              trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                list.companies.remove(item);
                _saveToStorage();
                setState(() {});
              }),
            ),
          ),
        );
      }).toList();

      return Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      );
    },
      future: storage.ready,
    );
  }
}
