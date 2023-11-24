// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, avoid_print

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia_fajarfirmansyah/constants/const.dart';
import 'package:vigenesia_fajarfirmansyah/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // String baseurl =
    //     "https://vigenesia.org/"; // ganti dengan ip address kamu / tempat kamu menyimpan backend
    Future postRegister(
        String nama, String profesi, String email, String password) async {
      var dio = Dio();
      dynamic data = {
        "nama": nama,
        "profesi": profesi,
        "email": email,
        "password": password
      };
      try {
        final response = await dio.post("$baseurl/api/registrasi/",
            data: data,
            options: Options(headers: {'Content-type': 'application/json'}));
        print("Respon -> ${response.data} + ${response.statusCode}");
        if (response.statusCode == 200) {
          return response.data;
        }
      } catch (e) {
        print("Failed To Load $e");
      }
    }

    TextEditingController nameController = TextEditingController();
    TextEditingController profesiController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 70,
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          SizedBox(height: 20),
          Text(
            "Hello! Register to get \nstarted",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w600, letterSpacing: -1.5),
          ),
          SizedBox(height: 24),
          Form(
            child: Column(
              children: [
                SizedBox(height: 12),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Color(0xff8391A1),
                    ),
                    filled: true,
                    // fillColor: Color(0xffF7F8F9),
                    fillColor: Theme.of(context).colorScheme.background,
                    hintText: "Nama",
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
                SizedBox(height: 12),
                TextFormField(
                  controller: profesiController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.group_add_outlined,
                      color: Color(0xff8391A1),
                    ),
                    filled: true,
                    // fillColor: Color(0xffF7F8F9),
                    fillColor: Theme.of(context).colorScheme.background,
                    hintText: "Profesi",
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
                SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xff8391A1),
                    ),
                    filled: true,
                    // fillColor: Color(0xffF7F8F9),
                    fillColor: Theme.of(context).colorScheme.background,
                    hintText: "Email",
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
                SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xff8391A1),
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off,
                      color: Color(0xff8391A1),
                    ),
                    filled: true,
                    // fillColor: Color(0xffF7F8F9),
                    fillColor: Theme.of(context).colorScheme.background,
                    hintText: "Password",
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
                      await postRegister(
                              nameController.text,
                              profesiController.text,
                              emailController.text,
                              passwordController.text)
                          .then((value) => {
                                if (value != null)
                                  {
                                    setState(() {
                                      // Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                      Flushbar(
                                        message: "Berhasil Registrasi",
                                        messageColor: Colors.black,
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.greenAccent,
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context);
                                    })
                                  }
                                else if (value == null)
                                  {
                                    Flushbar(
                                      message:
                                          "Check Your Field Before Register",
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.redAccent,
                                      flushbarPosition: FlushbarPosition.TOP,
                                    ).show(context)
                                  }
                              });
                    },
                    // onPressed: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => LoginScreen()));
                    // },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: -0.5,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0085FF),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
