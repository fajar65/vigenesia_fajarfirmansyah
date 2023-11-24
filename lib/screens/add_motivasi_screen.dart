// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia_fajarfirmansyah/constants/const.dart';
import 'package:vigenesia_fajarfirmansyah/constants/string.dart';

import '../models/motivasi_model.dart';

class AddMotivasiScreen extends StatefulWidget {
  final String? idUser;
  final String? nama;
  const AddMotivasiScreen({super.key, this.idUser, this.nama});

  @override
  State<AddMotivasiScreen> createState() => _AddMotivasiScreenState();
}

class _AddMotivasiScreenState extends State<AddMotivasiScreen> {
  TextEditingController isiController = TextEditingController();

  // String baseurl = url;
  String? id;
  var dio = Dio();
  GlobalKey keyMotivasi = GlobalKey<FormState>();

  Future<dynamic> postMotivasi(String isi) async {
    Dio dio = Dio();
    // URL endpoint API Anda
    String url = '$baseurl/rest_motivasi/index_post/';

    // Data yang ingin dikirim
    Map<String, dynamic> data = {
      "id": null,
      "isi_motivasi": isi,
      "iduser": "4",
      "tanggal_input": DateTime.now().toString(),
      "tanggal_update": DateTime.now().toString()
    };

    print("test id user = ${widget.idUser}");

    try {
      Response response = await dio.post(url, data: data);
      print('Response: ${response.data}');
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  List<MotivasiModel> listproduk = [];
  Future<List<MotivasiModel>> getData() async {
    var response = await dio.get('$baseurl/rest_motivasi/index_get');
    // var response = await dio
    //     .get('http://localhost:8888/vigenesia/rest_motivasi/index_get');
    print(" ${response.data}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var listUsers =
          getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> deletePost(String id) async {
    dynamic data = {
      "id": id,
    };
    var response = await dio.delete('$baseurl/rest_motivasi/index_delete/',
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Content-type": "application/json"}));
    print(" ${response.data}");
    var resbody = jsonDecode(response.data);
    return resbody;
  }

  Future<void> _getData() async {
    setState(() {
      getData();
    });
  }

  Future<void> refreshList() async {
    // Mock a network call
    await Future.delayed(Duration(milliseconds: 1300));

    setState(() {
      // Here you can update your list or fetch data from the server
      // For this example, the list will just be shuffled
      getData();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _getData();
  }

  // TextEditingController isiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
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
                key: keyMotivasi,
                child: Column(
                  children: [
                    TextFormField(
                      controller: isiController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.format_quote,
                          color: Color(0xff8391A1),
                        ),
                        filled: true,
                        // fillColor: Color(0xffF7F8F9),
                        fillColor: Theme.of(context).colorScheme.background,
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
                        onPressed: () async {
                          await postMotivasi(isiController.text.toString())
                              .then((value) => {
                                    if (value != null)
                                      {
                                        Flushbar(
                                          message: "Berhasil Submit",
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.greenAccent,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context)
                                      }
                                  });
                          _getData();
                          print("Sukses");

                          // print("Sukses");
                        },
                        // onPressed: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MainScreen()));
                        // },
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
