import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:codingclub/Pages/Quiz.dart';
import 'package:codingclub/model/EventsModel.dart';
import 'package:codingclub/model/QuizModel.dart' as qm;
import 'package:codingclub/model/Quizuser.dart' as qu;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/retry.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/ClubEvents.dart';
import '../Components/Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './Constants.dart' as Constants;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool isloading = true;
  List<qu.Data> standing = [];

  Future<dynamic> senddata() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
        Uri.parse(
          "${Constants.ProductionLink}/api/quiz-answers?populate=*",
        ),
        headers: headers);

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      var Quizuser = qu.QuizUser.fromJson(datadart);

      setState(() {
        standing = Quizuser.data as List<qu.Data>;
        isloading = false;
      });

      print(response.body);
    } else {
      // showAlertDialog2(context);
    }
  }

  @override
  void initState() {
    senddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("LeaderBoard",
              style: GoogleFonts.notoSerif(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22))),
      drawer: CusDrawer(),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft, child: Quiz()));
              },
              child: Container(
                child: Text("Quiz",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                        color: Colors.black, fontSize: 16)),
              ),
            )),
            Expanded(
                child: Container(
              height: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text("Leader Board",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSerif(
                        color: Colors.white, fontSize: 16)),
              ),
            ))
          ],
        ),
        height: 50,
        color: Color.fromRGBO(255, 208, 0, 1),
      ),
      body: !isloading
          ? ListView(children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Rank",
                          style: GoogleFonts.notoSerif(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("Roll No",
                          style: GoogleFonts.notoSerif(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      Text("Score",
                          style: GoogleFonts.notoSerif(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600))
                    ]),
              ),
              ...List.generate(
                  standing.length,
                  (index) => Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text((index + 1).toString(),
                                  style: GoogleFonts.notoSerif(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                              Text(
                                  standing[index].attributes!.rollno.toString(),
                                  style: GoogleFonts.notoSerif(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                              Text(standing[index].attributes!.marks.toString(),
                                  style: GoogleFonts.notoSerif(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ))
                            ]),
                      )).toList(),
            ])
          : Center(
              child: SpinKitCircle(
                color: Color.fromARGB(208, 0, 0, 0),
                size: 50.0,
              ),
            ),
    );
  }
}
