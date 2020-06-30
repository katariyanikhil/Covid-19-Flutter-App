import 'package:covid19/widgets/constant.dart';
import 'package:covid19/widgets/myHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Get to know",
              textBottom: "About Covid-19.",
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Symptoms",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    direction: Axis.horizontal,                    
                    spacing: 50.0,
                    runSpacing: 20.0,
                    children: <Widget>[
                      SymptomCard(
                        image: "assets/images/headache.png",
                        title: "Headache",
                        isActive: true,
                      ),
                      SymptomCard(
                        image: "assets/images/cough.png",
                        title: "Caugh",
                        isActive: true,
                      ),
                      SymptomCard(
                        image: "assets/images/fever.png",
                        title: "Fever",
                        isActive: true,
                      ),
                      SymptomCard(
                        image: "assets/images/sore_throat.png",
                        title: "Sore Throat",
                        isActive: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Prevention", style: kTitleTextstyle),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                        "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks.",
                    image: "assets/images/face_mask.png",
                    title: "Wear face mask",
                  ),
                  PreventCard(
                    text:
                        "Do not make any physical contact with other people to prevent spread of infections.",
                    image: "assets/images/avoid_contact.png",
                    title: "Avoid Physical Contact",
                  ),
                  PreventCard(
                    text:
                        "If yo feeling high cough cover your face in-order to prevent it from spreading.",
                    image: "assets/images/cover_cough.png",
                    title: "Cover your Nose",
                  ),
                  PreventCard(
                    text:
                        "Wash Your Handsevery 2-3 Hours to prevent bacteria and death causing virus entering your body.",
                    image: "assets/images/wash_hands.png",
                    title: "Wash your hands",
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: screenSize(150, context),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(
              image,
              width: 150.0,
            ),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: MediaQuery.of(context).size.width * 0.45,
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 100,
            fit: BoxFit.fill,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
