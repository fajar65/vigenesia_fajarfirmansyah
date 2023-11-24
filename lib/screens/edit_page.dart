// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:vigenesia_fajarfirmansyah/constants/colors.dart';
import 'package:vigenesia_fajarfirmansyah/constants/const.dart';
// import '/../Models/Motivasi_Model.dart';

class EditPage extends StatefulWidget {
  final String? id;
  final String? isiMotivasi;
  const EditPage({Key? key, this.id, this.isiMotivasi}) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // String baseurl =
  //     "https://vigenesia.org/"; // ganti dengan ip address kamu / tempat kamu menyimpan backend
  var dio = Dio();
  Future<dynamic> putPost(String isiMotivasi, String id) async {
    Map<String, dynamic> data = {"isi_motivasi": isiMotivasi, "id": id};
    var response = await dio.put('$baseurl/api/dev/PUTmotivasi',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ));
    print("---> ${response.data} + ${response.statusCode}");
    return response.data;
  }

  TextEditingController controllerMotivasi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.isiMotivasi}"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: FormBuilderTextField(
                  name: "isi_motivasi",
                  controller: controllerMotivasi,
                  decoration: InputDecoration(
                    labelText: "New Data",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {
                    putPost(controllerMotivasi.text, widget.id.toString())
                        .then((value) => {
                              if (value != null)
                                {
                                  Navigator.pop(context),
                                  Flushbar(
                                    message: "Berhasil Update & Refresh dlu",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.green,
                                    flushbarPosition: FlushbarPosition.TOP,
                                  ).show(context)
                                }
                            });
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      )),
    );
  }
}
