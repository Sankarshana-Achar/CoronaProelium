import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_app/src/Screens/UpdateView.dart';
import 'package:corona_app/src/Screens/History.dart';
import 'package:corona_app/src/Widget/Constants.dart';
import 'package:corona_app/src/Widget/Record.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_database/firebase_database.dart';

class Landing extends StatefulWidget {
  @override
  final email;
  final vname;
  final vstate;
  final vcity;
  String vcont;
  final vrating;
  Landing({Key key, @required this.email, @required this.vname, @required this.vstate, @required this.vcity, @required this.vcont, @required this.vrating}) : super(key: key);
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String vname;
  String vrating;
  String vcity;
  String vstate;
  List<String> recs = [];
  List<List<String>> rec = [];
  List<String> nameArr= [];
  List<String> typeArr= [];
  List<String> amountArr= [];
  List<String> addressArr = [];
  List<String> stateArr= [];
  List<String> cityArr= [];
  List<String> phoneArr= [];
  List<String> idArr= [];
  final dbRef = FirebaseDatabase.instance.reference().child("users");
  var current=1;
  String defaultState = "Delhi";
  List<String> cities = getCities("Delhi");
  String defaultType = "Vaccine";
  String defaultCity = "South Delhi";
  var update = UpdateView();
//  var historyClass = History();
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController controller = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController amount = new TextEditingController();

  @override
  Future<void> initState()  {
    super.initState();
    String at;
    var db = FirebaseDatabase.instance.reference().child("Volunteers/"+widget.vname+"/Records");
    var db1 =  FirebaseDatabase.instance.reference().child("Volunteers/"+widget.vname);
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
              if(key=="type"){
                typeArr.add(values);
              }
              if(key=="type"){
                typeArr.add(values);
              }
              if(key=="count"){
                amountArr.add(values);
              }
              idArr.add(at.split(" ")[2]);
            });

          });
        }});
    });
    print("INIT Over");
  }

  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          body: (current == 1) ? form() : (current == 0) ? LoadHistory() : profile(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: this.current,
            onTap : (index){
              setState(() {
                current = index;
              });
              print(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_outlined),
                title: Text("History"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                title: Text("New Update"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
              )
            ],
          ),
      ),
    );
  }

  Widget form(){
    return SingleChildScrollView(
      child: Column(
      children: <Widget>[
        SizedBox(height: 100),
        new ListTile(
          leading: const Icon(Icons.person),
          title: TextField(
            controller: name,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(),
              labelText: 'Enter Provider Name Here',
              hintText: 'Provider Name',
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.phone),
          title: new TextField(
            controller: phone,
            decoration: new  InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(),
              labelText: 'Enter Provider Phone Number Here',
              hintText: 'Phone Number',
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.email),
          title: new TextField(
            controller: address,
            decoration:  InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(),
              labelText: 'Enter Provider Address Here',
              hintText: 'Address',
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.email),
          title: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                color: Colors.blue,
                width: 2,
                //borderRadius: BorderRadius.all(Radius.circular(12.0)),
                //borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: DropdownButton<String>(
              value: defaultType,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String newValue) {
                setState(() {
                  defaultType = newValue;
                });
              },
              items: <String>['Vaccine', 'Oxygen', 'Bed']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.email),
          title: new TextField(
            controller: amount,
            decoration:  InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(),
              labelText: defaultType == "Vaccine" ? "Number of Bottles" : defaultType == "Bed" ? "Bed count" : "Amount in litres",
              hintText: defaultType == "Vaccine" ? "Number of Bottles" : defaultType == "Bed" ? "Bed count" : "Amount in litres",
            ),
          ),
        ),
        new ListTile(
          leading: const Icon(Icons.email),
          title: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                color: Colors.blue,
                width: 2,
                //borderRadius: BorderRadius.all(Radius.circular(12.0)),
                //borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: DropdownButton<String>(
              value: defaultState,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String newValue) {
                setState(() {
                  defaultState = newValue;
                  cities = getCities(defaultState);
                  defaultCity = cities[0];
                });
              },
              items: StatesOfIndia
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),),
        new ListTile(
          leading: const Icon(Icons.email),
          title: new Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                color: Colors.blue,
                width: 2,
                //borderRadius: BorderRadius.all(Radius.circular(12.0)),
                //borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: DropdownButton<String>(
              value: defaultCity,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String newValue) {
                setState(() {
                  defaultCity = newValue;
                });
              },
              items: cities
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),),

        new ListTile(
            title: new RaisedButton(
              shape: RoundedRectangleBorder(  borderRadius: new BorderRadius.circular(18.0),  side: BorderSide(color: Colors.black)),
              onPressed: (){
                print("Hello");
                updateValues();
                _buildPopupDialog(context);
              },
              child: new Text('Validate'),
            )
        ),
      ],
    ),
    );
  }

  Widget LoadHistory(){
    return FutureBuilder<Widget>(
      future: Load(context),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return snapshot.data;
        }else {
          return CircularProgressIndicator();
        }
      }
    );
  }
  Future <Widget> Load(BuildContext context) async {
    return Future.value(getRecordView());
  }

  Future <bool> _buildPopupDialog(BuildContext context) {
    return  Alert(
      context: context,
      type: AlertType.success,
      title: "Submission confirmed",
      desc: "Your submission has been recorded",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Future <bool> details(BuildContext context,String name) {
    return  Alert(
      context: context,
      type: AlertType.success,
      title: "Confirm deletion",
      desc: "Do you want to delete " + name,
      buttons: [
        DialogButton(
          child: Text(
            "OKAY",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
        DialogButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Future<Widget> getRecordView()  {
    var listview2 = ListView.builder(
      itemCount: int.parse(widget.vcont),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            details(context, nameArr[index]);
          },
          child: Record(
            name: nameArr[index],
            type: typeArr[index],
            address: addressArr[index],
            state: stateArr[index],
            phone:phoneArr[index],
            city: cityArr[index],
            id: idArr[index],
          )
        );
      },
    );  

      var items = List<Record>.generate(int.parse(widget.vcont), (index) => Record(
        name: nameArr[index],
        type: typeArr[index],
        address: addressArr[index],
        state: stateArr[index],
        phone:phoneArr[index],
        city: cityArr[index],
        id: idArr[index],
      ));
      print("Started");
      var listItems =  items;
      var listview = ListView.builder(
          itemCount: int.parse(widget.vcont),
          itemBuilder: (context,index){
            return listItems[index] ;
          }
      );
      return Future.value(listview2);
  }

  void updateValues(){
    addressArr.add(address.text);
    phoneArr.add(phone.text);
    stateArr.add(defaultState);
    cityArr.add(defaultCity);
    typeArr.add(defaultType);
    amountArr.add(amount.text);
    nameArr.add(name.text);

    var store = FirebaseDatabase.instance.reference();
    String newkey = store.reference().child("users/"+defaultState+"/"+defaultCity).push().key;
    store = FirebaseDatabase.instance.reference().child("users/"+defaultState+"/"+defaultCity);
    store.child(newkey).set({
      "name": name.text,
      "address": address.text,
      "phone": phone.text,
      "state": defaultState,
      "city": defaultCity,
      "type" : amount.text,
      "count" : defaultType,
    }).then((_) {
    }).catchError((onError) {
       print(onError);
    });
    var vlRef = FirebaseDatabase.instance.reference().child("Volunteers");
    widget.vcont = (int.parse(widget.vcont)+1).toString();
    vlRef = FirebaseDatabase.instance.reference().child("Volunteers/"+widget.vname);
    vlRef.update({
      "Contributions": widget.vcont,
    }).then((_) {
    }).catchError((onError) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(onError)));
    });

    vlRef = FirebaseDatabase.instance.reference().child("Volunteers/"+widget.vname+"/Records");
    vlRef.push().update({
      "cont": defaultState + " " + defaultCity + " " + newkey,
    }).then((_) {
    }).catchError((onError) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(onError)));
    });
  }


  Widget profile(){

    return SingleChildScrollView(

        child : Column(
              children: [
                Container(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      alignment: Alignment(0.0,2.5),
                      ),
                    ),
                  ),
                Text(
                  widget.vname,
                  style: TextStyle(
                    fontSize: 25.0,
                    color:Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.vcity + "  " + widget.vstate,
                    style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Volunteer"
                  ,style: TextStyle(
                    fontSize: 15.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(
                  height: 100,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("Rating",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600
                                ),),
                              SizedBox(
                                height: 7,
                              ),
                              Text(widget.vrating,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w300
                                ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child:
                          Column(
                            children: [
                              Text("Contributions",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600
                                ),),
                              SizedBox(
                                height: 7,
                              ),
                              Text(widget.vcont,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w300
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
      ),);
    }

}


