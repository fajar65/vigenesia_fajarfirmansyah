// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace, unused_element

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia_fajarfirmansyah/constants/colors.dart';
import 'package:vigenesia_fajarfirmansyah/constants/const.dart';

import 'package:vigenesia_fajarfirmansyah/constants/string.dart';
import 'package:vigenesia_fajarfirmansyah/constants/theme_provider.dart';
import 'package:vigenesia_fajarfirmansyah/screens/add_motivasi_screen.dart';
import 'package:vigenesia_fajarfirmansyah/screens/edit_page.dart';
import 'package:vigenesia_fajarfirmansyah/screens/login_screen.dart';

import '../models/motivasi_model.dart';

class MainScreen extends StatefulWidget {
  final String? idUser;
  final String? nama;
  final bool? isDarkMode;
  final Function? toggleTheme;
  const MainScreen(
      {super.key, this.nama, this.isDarkMode, this.toggleTheme, this.idUser});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // String baseurl =
  //     "https://vigenesia.org/"; // ganti dengan ip address kamu / tempat kamu menyimpan backend
  // String baseurl = "http://localhost:8888/vigenesia/";
  String? id;
  var dio = Dio();

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

  Future<List<MotivasiModel>> getDataByUser() async {
    var response = await dio.get(
        '$baseurl/rest_motivasi/index_get?iduser=${widget.idUser}'); // NGambil by data
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

  Future<List<dynamic>> searcMotivasi(String query) async {
    var dio = Dio();
    try {
      String url = '$baseurl/rest_motivasi/index_get/';
      var response = await dio.get(url, queryParameters: {'query': query});

      if (response.statusCode == 200) {
        return response.data; // Asumsikan data ada di body response
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Terjadi kesalahan saat mengambil data');
    }
  }

  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    try {
      var results = await searcMotivasi(searchController.text);
      setState(() {
        searchResults = results;
      });
    } catch (e) {
      print(e.toString());
      // Tampilkan dialog error atau snackbar
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _getData() async {
    setState(() {
      getData();
      listproduk.clear();
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

  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    getDataByUser();
    _getData();
  }

  bool isDarkMode = false;

  toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  String? trigger;
  String? triggerUser;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    ItemPopup? itemPopup;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // backgroundColor: AppColors.primaryColor,
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
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatar1),
          ),
          title: Text(
            "Hello,",
            style: TextStyle(
                fontSize: 12,
                letterSpacing: -1,
                color: Theme.of(context).colorScheme.background),
          ),
          subtitle: Text(
            "${widget.nama}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              letterSpacing: -0.5,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                bottomSheet(context);
              },
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.background,
              )),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        displacement: 20,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        child: Container(
          // color: AppColors.primaryColor,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: height / 2.4,
                decoration: BoxDecoration(color: AppColors.primaryColor),
              ),
              ListView(
                // padding: EdgeInsets.symmetric(horizontal: 24),
                children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(color: AppColors.primaryColor),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selamat Datang di Vigenesia",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "- Visi Generasi Indonesia",
                                    style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: -0.5,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          imgHeader2,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),

                  // FormBuilderRadioGroup(
                  //     onChanged: (value) {
                  //       setState(() {
                  //         trigger = value;
                  //         print(" HASILNYA --> ${trigger}"); // hasil ganti value
                  //       });
                  //     },
                  //     name: "_",
                  //     options: ["Motivasi by all", "Motivasi by user"]
                  //         .map((e) =>
                  //             FormBuilderFieldOption(value: e, child: Text("${e}")))
                  //         .toList()),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "List Visi",
                            style: TextStyle(letterSpacing: -0.5),
                          ),
                        ),
                        Container(
                          width: width,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: FutureBuilder(
                              future: getData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<MotivasiModel>> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      for (var item in snapshot.data!)
                                        Container(
                                          margin: EdgeInsets.only(bottom: 18),
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color:
                                                getRandomPastelColorWithOpacity(
                                                    Opacity(opacity: 0.15)),
                                            border: Border.all(
                                                color:
                                                    getRandomPastelColorWithOpacity(
                                                  Opacity(opacity: 1),
                                                ),
                                                width: 1.5),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: width / 1.5,
                                                    child: Text(
                                                      "\"${item.isiMotivasi}\"",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: -0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.format_quote_rounded,
                                                    size: 32,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                visualDensity: VisualDensity(
                                                    horizontal: 0,
                                                    vertical: -4),
                                                dense: true,
                                                leading: CircleAvatar(
                                                  radius: 16,
                                                  backgroundImage:
                                                      AssetImage(avatar2),
                                                ),
                                                title: Text(
                                                  "${widget.nama}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      letterSpacing: -0.5,
                                                      // color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing:
                                                    PopupMenuButton<ItemPopup>(
                                                  icon: Icon(Icons.more_vert),
                                                  initialValue: itemPopup,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  // Callback that sets the selected popup menu item.
                                                  onSelected: (ItemPopup item) {
                                                    setState(() {
                                                      itemPopup = item;
                                                    });
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          <PopupMenuEntry<
                                                              ItemPopup>>[
                                                    PopupMenuItem<ItemPopup>(
                                                      value: ItemPopup.edit,
                                                      child: InkWell(
                                                        onTap: () {
                                                          String id;
                                                          String isiMotivasi;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    EditPage(
                                                                        id: item
                                                                            .id,
                                                                        isiMotivasi:
                                                                            item.isiMotivasi),
                                                              ));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.edit,
                                                                size: 18,
                                                                color: Colors
                                                                    .green),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem<ItemPopup>(
                                                      value: ItemPopup.delete,
                                                      child: InkWell(
                                                        onTap: () {
                                                          deletePost(item.id)
                                                              .then((value) => {
                                                                    if (value !=
                                                                        null)
                                                                      {
                                                                        Flushbar(
                                                                          message:
                                                                              "Berhasil Hapus",
                                                                          duration:
                                                                              Duration(seconds: 2),
                                                                          backgroundColor:
                                                                              Colors.redAccent,
                                                                          flushbarPosition:
                                                                              FlushbarPosition.TOP,
                                                                        ).show(
                                                                            context)
                                                                      }
                                                                  });
                                                          _getData();
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete,
                                                                size: 18,
                                                                color:
                                                                    Colors.red),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Hapus',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      SizedBox(height: 100),
                                    ],
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isEmpty) {
                                  return Center(child: Text("No Data"));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// bottomsheet settings
  void bottomSheet(BuildContext context) {
    bool isDarkMode = false;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                height: 200,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            print("dark");
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode),
                            title:
                                Text('Tema ${isDarkMode ? "Terang" : "Gelap"}'),
                            trailing: Switch(
                              value: isDarkMode,
                              onChanged: (bool value) {
                                // Update the state of the bottom sheet
                                setState(() {
                                  isDarkMode = value;
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .toggleTheme();
                                });
                                // Optionally update the state of the main page
                                this.setState(() {
                                  isDarkMode = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            confirmLogout(context);
                            print("logout");
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.logout),
                            title: Text("Keluar"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          });
        });
  }

// bottomsheet confirm logout
  void confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          title: Center(child: Text('Keluar')),
          content: Text(
            'Kamu yakin ingin keluar?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (_) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // bottomsheet confirm delete
  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          title: Center(child: Text('Hapus motivasi')),
          content: Text(
            'Kamu yakin ingin hapus motivasi ini ?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (_) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

enum ItemPopup { edit, delete }
