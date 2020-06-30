import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:convert';
import 'package:covid19/screens/stateScreen.dart';
import 'package:covid19/screens/infoScreen.dart';
import 'package:covid19/widgets/myHeader.dart';
import 'package:covid19/widgets/counter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid19/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/service/countryData.dart';
import 'package:toast/toast.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int ctot,cdeaths,crecover;
  String updateDate = DateTime.now().toString().substring(0,10);
  var finalData,jsonData;
  Countries data;
  String apiURL = "https://api.covid19api.com/summary";
  String currentCountry = "India";

  Future<void> getData() async {
    final response = await http.get(apiURL);
    jsonData = json.decode(response.body);
    data = Countries.fromJson(jsonData);
    finalData = data.toJson();
    finalData = finalData['Stats'];
    setState(() {
      for (var d in finalData) {
        countryList.add(d['Country'].toString());
      }
    });
    countryList.sort();
    updateData(currentCountry);
  }

  void updateData(String country){
    for (var d in finalData) {
        if(d['Country'].toString() == country){
          ctot = d['TotalConfirmed'];
          cdeaths = d['TotalDeaths'];
          crecover = d['TotalRecovered'];
          updateDate = d['Date'].toString().substring(0,10);
        }
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              icon: SvgPicture.asset("assets/icons/menu.svg",width: 30,),
              navigate: InfoScreen(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: currentCountry,
                      items: countryList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 15.0
                              ),
                            ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          currentCountry = value;
                          updateData(currentCountry);
                          
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update $updateDate",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          if(currentCountry.toLowerCase() == "india"){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return StateScreen();
                              },
                            ));
                          }else {
                              Toast.show('Sorry Currently Unavailable!.', context,backgroundColor: kBodyTextColor,textColor: kBackgroundColor);
                          }
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),                    
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: ctot,
                          title: "Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: cdeaths,
                          title: "Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: crecover,
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                      GestureDetector(
                        onTap: (){
                          Toast.show('Sorry Currently Unavailable!.', context,backgroundColor: kBodyTextColor,textColor: kBackgroundColor);
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),                    
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
