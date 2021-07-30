import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_app/src/Widget/Record.dart';
import 'package:firebase_database/firebase_database.dart';

class History extends StatefulWidget {

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
/*  List<String> nameArr= [];
  List<String> typeArr= ["vaccine","bed"];
  List<String> addressArr = [];
  List<String> stateArr= [];
  List<String> cityArr= [];
  List<String> phoneArr= [];
  List<String> idArr= [];

  @override
  Future<void> initState() {
    super.initState();
    int i=0;
    String at;
    var cont =0;
    var db = FirebaseDatabase.instance.reference().child("Volunteers/"+widget.vname+"/Records");
    var db1 = FirebaseDatabase.instance.reference().child("Volunteers/"+widget.vname);
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      print(values);
      values.forEach((key1,values) async {
        if(values["cont"]!=null){
          at = values["cont"];
          print("371 ::::::::::: CONT :::::::: "+at);
          db1 = await FirebaseDatabase.instance.reference().child("users/"+at.split(" ")[0]+"/"+at.split(" ")[1]+"/"+at.split(" ")[2]);
          print("users/"+at.split(" ")[0]+"/"+at.split(" ")[1]+"/"+at.split(" ")[2]);
          db1.once().then((DataSnapshot snapshot){
            Map<dynamic, dynamic> values = snapshot.value;
            print(values);
            values.forEach((key,values) {
              print(values);
              if(key=="address"){
                addressArr.add(values);
              }
              if(key=="name"){
                nameArr.add(values);
              }
              if(key=="phone"){
                phoneArr.add(values);
              }
              if(key=="city"){
                cityArr.add(values);
              }
              if(key=="state"){
                stateArr.add(values);
              }
              idArr.add(at.split(" ")[2]);
            });
            print("Over");
          });
        }});
    });
  }
  List<Record> getRecordElements(){
    var items = List<Record>.generate(10, (index) => Record(
      name: "Ragav",
      type: "vaccine",
      address: "Yo yo",
      state: "tamilnadu",
      phone:"9994426595",
      city: "Cbe",
    ));
    var item2 = List<Record>.generate(10, (index) => Record(
      name: "Jphn",
      type: "bed",
      address: "Yo yo",
      state: "tamilnadu",
      phone:"9994426595",
      city: "MAdurai",
    ));
    var item3 = List<Record>.generate(10, (index) => Record(
      name: "Harish",
      type: "oxygen",
      address: "Yd",
      state: "tamilnadu",
      phone:"9994466595",
      city: "Neyveli",
    ));
    return items;
  }
  Widget getRecordView(){
    var listItems = getRecordElements();
    var listview = ListView.builder(
        itemBuilder: (context,index){
          return listItems[index];
        }
    );
    return listview;
  }
*/
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text("Hello"),
      ),
    );
  }
}
