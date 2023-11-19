// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:vigenesia_fajarfirmansyah/constants/string.dart';
import 'package:vigenesia_fajarfirmansyah/screens/add_motivasi_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMotivasiScreen()),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          width: width / 1.7,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xff0085FF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logoZarr, height: 40),
              SizedBox(width: 14),
              Text(
                "Buat motivasi",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 14),
              Icon(Icons.add, color: Colors.white),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatar1),
          ),
          title: Text(
            "Hello,",
            style: TextStyle(fontSize: 12, letterSpacing: -1),
          ),
          subtitle: Text(
            "Fajar Firmansyah",
            style: TextStyle(
              letterSpacing: -1,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
              )),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          // SizedBox(height: 15),
          Divider(),
          SizedBox(height: 10),
          for (int i = 0; i < 3; i++)
            Container(
              child: Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(avatar2),
                      ),
                      title: Text(
                        "Fajar Firmansyah",
                        style: TextStyle(
                            letterSpacing: -1, fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.more_vert)),
                  SizedBox(height: 15),
                  Container(
                    height: 180,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(imgList),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: width / 2.4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(0.2),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => AddMotivasiScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: -0.5,
                                    color: Colors.green),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: width / 2.4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.1),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => AddMotivasiScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Comment',
                                style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: -0.5,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
