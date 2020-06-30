import 'package:covid19/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHeader extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final Widget icon;
  final Widget navigate;

  const MyHeader({
    Key key,
    this.image,
    this.textTop,
    this.textBottom,
    @required this.icon,
    this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 25, right: 10),
        height: 350,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  if(navigate != null){
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return navigate;
                      },
                    ),
                  );
                  }else {
                    Navigator.pop(context);
                  }
                },
                child: icon,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
              
                children: <Widget>[
                  SvgPicture.asset(
                    image,
                    width: 230,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    top: 20,
                    left: 150,
                    child: Text(
                      "$textTop \n$textBottom",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(), // I dont know why it can't work without container
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
