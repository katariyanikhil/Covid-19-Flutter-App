import 'package:covid19/charts/waveProgress.dart';
import 'package:flutter/material.dart';

// Colors
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);

const double baseHeight = 650.0;

double screenSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

Widget vaweCard(BuildContext context, String name, String f, String total,
      Color fillColor, Color bgColor) {
    String a = f.replaceAll(RegExp(','), '');
    String b = total.replaceAll(RegExp(','), '');
    double c = (((double.parse(a).ceil() / double.parse(b).ceil())) * 100);
    String x = c.toStringAsFixed(2);

    return Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenSize(80, context),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              WaveProgress(
                screenSize(45, context),
                fillColor,
                bgColor,
                67,
              ),
              Text(
                "${x.toString()}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.grey[750], fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${f.toString()}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

List<String> countryList = [];
List<String> stateList = [];