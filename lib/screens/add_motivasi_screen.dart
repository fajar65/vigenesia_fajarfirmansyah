// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:vigenesia_fajarfirmansyah/constants/string.dart';
import 'package:vigenesia_fajarfirmansyah/screens/main_screen.dart';

class AddMotivasiScreen extends StatefulWidget {
  const AddMotivasiScreen({super.key});

  @override
  State<AddMotivasiScreen> createState() => _AddMotivasiScreenState();
}

class _AddMotivasiScreenState extends State<AddMotivasiScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          "Add Motivasi",
          style: TextStyle(
            fontSize: 18,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 24, bottom: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400)),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: height / 1.6,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgAddMotivasi),
                fit: BoxFit.cover,
              ),
            ),
            // child: Image.asset(bgAddMotivasi),
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              SizedBox(height: 80),
              Text(
                "Motivasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.5),
              ),
              SizedBox(height: 2),
              Text(
                "Visi Generasi Indonesia",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    letterSpacing: -1.5),
              ),
              SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.format_quote,
                          color: Color(0xff8391A1),
                        ),
                        filled: true,
                        fillColor: Color(0xffF7F8F9),
                        hintText: "Motivasi",
                        hintStyle: TextStyle(color: Color(0xff8391A1)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff0085FF),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffE8ECF4),
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffE8ECF4),
                            )),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: -0.5,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
