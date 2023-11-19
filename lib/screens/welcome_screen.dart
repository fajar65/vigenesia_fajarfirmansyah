// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vigenesia_fajarfirmansyah/constants/string.dart';
import 'package:vigenesia_fajarfirmansyah/screens/login_screen.dart';
import 'package:vigenesia_fajarfirmansyah/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.white;
    return Material(
      child: Stack(children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [gradientStart, gradientEnd],
            ).createShader(
                Rect.fromLTRB(0, -140, rect.width, rect.height - 20));
          },
          // blendMode: BlendMode.darken,
          child: Container(
            height: height / 1.2,
            width: width,
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     colors: [gradientStart, gradientEnd],
              //     begin: FractionalOffset(0, 0),
              //     end: FractionalOffset(0, 1),
              //     stops: [0.0, 1.0],
              //     tileMode: TileMode.clamp),
              image: DecorationImage(
                image: ExactAssetImage(bgWelcome),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: SizedBox.shrink()),
              Expanded(
                flex: 0,
                child: Image.asset(
                  logoZarr,
                  height: 58,
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  margin: EdgeInsets.only(bottom: 28.0),
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  constraints: BoxConstraints(
                    maxWidth: 330.0,
                  ),
                  child: Text(
                    'Zarr Vision - Vigenesia',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                // padding: EdgeInsets.symmetric(vertical: 18),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                width: width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0085FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16, letterSpacing: -0.5, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                // padding: EdgeInsets.symmetric(vertical: 18),
                height: 54,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xffAAAAAA),
                      width: 0.7,
                    )),
                width: width,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 16, letterSpacing: -0.5, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ]),
    );
  }
}
