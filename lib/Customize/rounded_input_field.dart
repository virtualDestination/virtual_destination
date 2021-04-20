import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:virtual_destination/Customize/forcedMode.dart';
import 'package:virtual_destination/colors.dart';
import 'package:virtual_destination/common components/text_field_container.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  String stringChanged;
  final List suggestions;
  final GlobalKey kEy;

   RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.stringChanged,
      this.kEy,
      this.suggestions})
      : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: AutoCompleteTextField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white
              )
            )
          ),
          clearOnSubmit: false,
            itemSubmitted: (str){
            setState(() {
              if(widget.stringChanged=="from"){
                forcedFromField = str;
              }else if(widget.stringChanged == "to"){
                forcedToField = str;
              }else if(widget.stringChanged=="flight"){
                forcedFlightField = str;
              }else if(widget.stringChanged=="hotel"){
                forcedHotelField = str;
              }else if(widget.stringChanged=="car"){
                forcedCarField = str;
              }
            });
            },
            key: widget.kEy,
            suggestions: widget.suggestions,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Text(
                  index,
                  style: TextStyle(fontSize: size.width * 0.04),
                ),
              );
            },
            itemSorter: (a, b) {
              return a.compareTo(b);
            },
            itemFilter: (item, query) {
              return item.toLowerCase().startsWith(query.toLowerCase());
            }));
  }
}
