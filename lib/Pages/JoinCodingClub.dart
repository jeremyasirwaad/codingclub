import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:codingclub/Components/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Constants.dart' as Constants;

class JoinCodingClub extends StatefulWidget {
  JoinCodingClub({Key? key}) : super(key: key);

  @override
  State<JoinCodingClub> createState() => _JoinCodingClubState();
}

class _JoinCodingClubState extends State<JoinCodingClub> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController _FullName = TextEditingController();
  TextEditingController _Department = TextEditingController();
  TextEditingController _RollNo = TextEditingController();
  TextEditingController _WhatsappNo = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _Batch = TextEditingController();

  Future<dynamic> senddata() async {
    Map<String, dynamic> body = {
      'data': {
        "fullname": _FullName.text,
        "department": _Department.text,
        "rollno": _RollNo.text,
        "batch": _Batch.text,
        "whatsappno": _WhatsappNo.text,
        "email": _Email.text
      },
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
        Uri.parse(
          '${Constants.ProductionLink}/api/club-enquires',
        ),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // await Analytics.analytics.logEvent(
      //   name: "Joining request",
      //   parameters: <String, dynamic>{
      //     'name': _FullName.text,
      //     'rollnumber': _RollNo.text,
      //   },
      // );
      showAlertDialog(context);
    } else {
      showAlertDialog2(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     toolbarHeight: 70,
      //     iconTheme: IconThemeData(color: Colors.black),
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     title: Text(
      //       "Join Coding Club",
      //       style: GoogleFonts.notoSerif(
      //           fontWeight: FontWeight.w600,
      //           color: Color.fromARGB(255, 0, 0, 0),
      //           fontSize: 22),
      //     )),
      // drawer: CusDrawer(),
      body: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          color: Colors.white,
          child: ListView(
            children: [
              Image.asset(
                "assets/images/Joinusimg.png",
                height: 200,
                width: 200,
              ),
              Text(
                "Get On Board!",
                style: GoogleFonts.notoSerif(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 26),
              ),
              Text(
                "Enter the details below to start your Journey",
                style: GoogleFonts.notoSerif(
                    color: Color.fromARGB(255, 111, 111, 111), fontSize: 13),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 600,
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: _FullName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              label: Text("Full Name"),
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: _Department,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              label: Text("Department (ECE, IT, CSC, etc)"),
                              prefixIcon: Icon(Icons.build),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: _RollNo,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              prefixIcon: Icon(Icons.format_list_numbered),
                              label: Text("Roll No"),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: _Batch,
                          validator: (value) {
                            if (value!.length == 4) {
                              return null;
                            } else {
                              return "Enter Valid batch";
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              prefixIcon: Icon(Icons.numbers_rounded),
                              label: Text("Batch (2024, 2023, etc)"),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: _WhatsappNo,
                          validator: (value) {
                            if (value!.length != 10)
                              return '';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              label: Text("Whatapp No"),
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: _Email,
                          validator: (input) =>
                              input!.isValidEmail() ? null : "Check your email",
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              prefixIcon: Icon(Icons.mail),
                              label: Text("Email"),
                              border: OutlineInputBorder()),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(255, 208, 0, 1),
                              onPrimary: Colors.black,
                              textStyle: TextStyle(color: Colors.black)),
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              senddata();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Sending request')),
                              );
                            }
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.notoSerif(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        Text(
                          "Interested to Contribute for the app ?",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 111, 111, 111),
                              fontSize: 14),
                        ),
                        Text(
                          "Contact +919843632220",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 111, 111, 111),
                              fontSize: 14),
                        ),
                      ]),
                ),
              )
            ],
          )),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(255, 208, 0, 1),
        onPrimary: Colors.black,
        textStyle: TextStyle(color: Colors.black)),
    child: Text(
      "OK",
      style: GoogleFonts.notoSerif(fontSize: 16),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Request Sent",
      style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Thanks for your interest in GCT's Coding Club. We will contact you shortly.",
      style: GoogleFonts.notoSerif(fontSize: 16),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(255, 208, 0, 1),
        onPrimary: Colors.black,
        textStyle: TextStyle(color: Colors.black)),
    child: Text(
      "OK",
      style: GoogleFonts.notoSerif(fontSize: 16),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Request Received Already",
      style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    content: Text(
      "We have already received your request, kindly wait untill we contact you.",
      style: GoogleFonts.notoSerif(fontSize: 16),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
