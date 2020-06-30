import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid19/widgets/constant.dart';
import 'package:covid19/screens/homeScreen.dart';

void main(){ 
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kPrimaryColor,
  ));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(
              color: kBodyTextColor,
            ),
          ),
          platform: TargetPlatform.iOS,
        ),
      home: WelcomeLogo(),
    );
  }
}

class WelcomeLogo extends StatefulWidget {
  @override
  _WelcomeLogoState createState() => _WelcomeLogoState();
}


class _WelcomeLogoState extends State<WelcomeLogo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Image.asset(
                'assets/icons/appicon.png',
                height: 150.0,
                width: 150.0,
              ),
              Text(
                'COVID-19',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
