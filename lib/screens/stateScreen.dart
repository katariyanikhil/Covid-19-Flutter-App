import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid19/service/statewise.dart';
import 'package:covid19/widgets/constant.dart';
import 'package:covid19/widgets/myHeader.dart';
import 'package:toast/toast.dart';


class StateScreen extends StatefulWidget {
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List<StateWise> test, sample, _dat1;

  var jsondata;
  States data;
  String apiURL = "https://api.rootnet.in/covid19-in/stats/latest";
  
  Future<void> getData() async {
    final response = await http.get(apiURL);
    jsondata = json.decode(response.body);
    data = States.fromJson(jsondata);
    test = data.stateWise;
    setState(() {
      sample = test;
      _dat1 = sample;
      
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getData,
        child: Column(
        children: <Widget>[
          //TOPBAR
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(left: 25, top: 50, right: 10),
              height: 175,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/virus.png"),
                ),
              ),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                onTap: () {
                    Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                  ),
                ),
              ),
              SizedBox(width: 20,),
                Container(
                  width: screenSize(250, context),
                  padding: EdgeInsets.only(left: 20),
                  height: screenSize(40, context),
                  decoration: BoxDecoration(
                      color: Color(0xFF3383CD),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0))),
                  child: TextField(
                    style: new TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Here...',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: Icon(Icons.search, color: Colors.white)
                    ),
                    onChanged: (text) {
                      setState(() {
                        _dat1 = sample.where((r) => r.stateName.toLowerCase().contains(text.trim().toLowerCase())).toList();
                      });
                    },
                  ),
                ),
              ],
            ),
            ),
          ),
          //TOPBAREND
          data == null ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            )
          : Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: _dat1
                .map((pointer) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    padding:  EdgeInsets.only(left: 7),
                    child: InkWell(
                      onTap: (){
                        Toast.show(pointer.stateName.toString(), context);
                      },
                      child: Card(
                        color: kBackgroundColor,
                        margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/icons/appicon.png"),
                          ),
                          title: Text(
                            pointer.stateName.toUpperCase(),
                            style: TextStyle(
                              color: kTitleTextColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            "Total Cases : "+ pointer.totConfirmed.toString(),
                            style: TextStyle(color: kTextLightColor),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right,
                            color: kPrimaryColor,),
                            iconSize: 30,
                            onPressed: (){
                              Toast.show('Show State Details', context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ), 
      ),     
    );
  }
}
