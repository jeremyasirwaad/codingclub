import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:codingclub/Pages/LeaderBoard.dart';
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

class Quiz extends StatefulWidget {
  Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<qm.Data> _Quiz = [];
  bool isloading = true;
  int? checkboxValue;
  TextEditingController _RollNo = TextEditingController();
  bool _isButtonVisible = false;

  bool checktime() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 10 && hour >= 18) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('${Constants.ProductionLink}/api/weekly-quizs'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      print(response.body);

      setState(() {
        isloading = false;
        _Quiz = qm.QuizModel.fromJson(datadart).data as List<qm.Data>;
      });
      print(_Quiz.length);
    } else {
      print("Null detectded");

      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> senddata() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
        Uri.parse(
          "${Constants.ProductionLink}/api/quiz-answers?filters[rollno][\$eq]=${_RollNo.text.toUpperCase()}&populate=*",
        ),
        headers: headers);

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      var Quizuser = qu.QuizUser.fromJson(datadart);
      if (Quizuser.data!.isEmpty) {
        pushQuiz();
        storeTomorrowDate();
      } else {
        appendQuiz(Quizuser.data![0].attributes!.answers as List<qu.Answers>,
            Quizuser.data![0].id as int);
        storeTomorrowDate();
      }

      print(response.body);
    } else {
      // showAlertDialog2(context);
    }
  }

  Future<dynamic> pushQuiz() async {
    Map<String, dynamic> body = {
      'data': {
        "rollno": _RollNo.text.toString().toUpperCase(),
        "answers": [
          {
            "quiz_id": _Quiz[_Quiz.length - 1].attributes!.quizId.toString(),
            "student_ans": "op$checkboxValue",
          }
        ],
      },
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
        Uri.parse(
          "${Constants.ProductionLink}/api/quiz-answers",
        ),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Fresh Quiz Used Added");
    } else {
      print("Pronlem in Fresh Quiz Used Added");
      print(response.body);
    }
  }

  Future<dynamic> appendQuiz(List<qu.Answers> userAnswer, int id) async {
    userAnswer.add(qu.Answers(
      quiz_id: _Quiz[_Quiz.length - 1].attributes!.quizId.toString(),
      student_ans: "op$checkboxValue",
    ));

// Assuming userAnswer is a List<qu.Answers>

    var data = userAnswer;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var jsonData = jsonEncode({
      "data": {
        "answers": userAnswer
            .map((answer) => {
                  "quiz_id": answer.quiz_id,
                  "student_ans": answer.student_ans,
                })
            .toList(),
      }
    });

    final response = await http.put(
        Uri.parse(
          "${Constants.ProductionLink}/api/quiz-answers/$id",
        ),
        headers: headers,
        body: jsonData);

    if (response.statusCode == 200) {
      print("Append Quiz Used Added");
    } else {
      print("Error in Append in Fresh Quiz Used Added");
      print(response.body);
    }
  }

  String getAnswer(int value) {
    if (_Quiz.isNotEmpty && value >= 1 && value <= 4) {
      final attributes = _Quiz[_Quiz.length - 1]
          .attributes!; // Assuming attributes is not null

      switch (value) {
        case 1:
          return attributes.op1.toString();
        case 2:
          return attributes.op2.toString();
        case 3:
          return attributes.op3.toString();
        case 4:
          return attributes.op4.toString();
        default:
          return "Invalid value";
      }
    } else {
      return "Invalid value or empty quiz list";
    }
  }

  Future<void> storeTomorrowDate() async {
    final prefs = await SharedPreferences.getInstance();

    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 10, 0, 0);

    await prefs.setString('nextShowTime', tomorrow.toIso8601String());
    await prefs.setString('answer', checkboxValue.toString());

    setState(() {
      _isButtonVisible = false;
    });
  }

  void isStoredDateGreaterThanNow() async {
    final prefs = await SharedPreferences.getInstance();
    final nextShowTimeStr = prefs.getString('nextShowTime');

    if (nextShowTimeStr != null) {
      final nextShowTime = DateTime.parse(nextShowTimeStr);
      final now = DateTime.now();
      print(nextShowTime);
      if (now.isAfter(nextShowTime)) {
        setState(() {
          _isButtonVisible = true;
        });
      } else {
        setState(() {
          _isButtonVisible = false;
        });
      }
    } else {
      setState(() {
        _isButtonVisible = true;
      });
    }

    final storedans = prefs.getString('answer');

    if (storedans != null) {
      setState(() {
        checkboxValue = int.parse(storedans);
      });
    }

    // setState(() {
    //   _isButtonVisible = true;
    // });
    // return false;
  }

  @override
  void initState() {
    fetchAlbum();
    isStoredDateGreaterThanNow();
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
          title: Text("Daily Quiz",
              style: GoogleFonts.notoSerif(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22))),
      drawer: CusDrawer(),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: Text("Quiz",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.notoSerif(color: Colors.black, fontSize: 16)),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: LeaderBoard()));
              },
              child: Container(
                height: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text("Leader Board",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSerif(
                          color: Colors.white, fontSize: 16)),
                ),
              ),
            ))
          ],
        ),
        height: 50,
        color: Color.fromRGBO(255, 208, 0, 1),
      ),
      body: !isloading
          ? SingleChildScrollView(
              child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Question - ${_Quiz[_Quiz.length - 1].attributes!.quizId}",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSerif(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _Quiz[_Quiz.length - 1].attributes!.question as String,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSerif(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(a) ${_Quiz[_Quiz.length - 1].attributes!.op1}",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Radio<int?>(
                              value: 1,
                              groupValue: checkboxValue,
                              onChanged: (int? value) {
                                setState(() {
                                  checkboxValue = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(b) ${_Quiz[_Quiz.length - 1].attributes!.op2}",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Radio<int?>(
                              value: 2,
                              groupValue: checkboxValue,
                              onChanged: (int? value) {
                                setState(() {
                                  checkboxValue = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(c) ${_Quiz[_Quiz.length - 1].attributes!.op3}",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Radio<int?>(
                              value: 3,
                              groupValue: checkboxValue,
                              onChanged: (int? value) {
                                setState(() {
                                  checkboxValue = value;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(d) ${_Quiz[_Quiz.length - 1].attributes!.op4}",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Radio<int?>(
                            value: 4,
                            groupValue: checkboxValue,
                            onChanged: (int? value) {
                              setState(() {
                                checkboxValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      child: checktime()
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: Center(
                                    child: Text(
                                        "Correct Answer is ${getAnswer(int.parse(_Quiz[_Quiz.length - 1].attributes!.ans![2] as String))}",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.notoSerif(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                            fontSize: 17)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Stay tuned, Next Quiz at 10AM",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.notoSerif(
                                        color: Colors.black, fontSize: 15)),
                              ],
                            )
                          : Container()),
                  SizedBox(
                    height: 40,
                  ),
                  !checktime()
                      ? _isButtonVisible
                          ? Column(
                              children: [
                                Container(
                                  child: TextFormField(
                                    controller: _RollNo,
                                    validator: (value) {
                                      if (value!.length != 10)
                                        return '';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        label: Text("Roll Number"),
                                        prefixIcon: Icon(Icons.numbers),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(
                                    "* Roll No will be used for leaderboard",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // padding: EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(255, 208, 0, 1),
                                        onPrimary: Colors.black,
                                        textStyle:
                                            TextStyle(color: Colors.black)),
                                    onPressed: () {
                                      senddata();
                                    },
                                    child: Text(
                                      "Submit",
                                      style:
                                          GoogleFonts.notoSerif(fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Quiz Attended",
                                        style: GoogleFonts.notoSerif(
                                            color: Colors.black, fontSize: 15)),
                                    Text("Answers Will be out by 6pm",
                                        style: GoogleFonts.notoSerif(
                                            color: Colors.black, fontSize: 15))
                                  ]),
                            )
                      : Container(),
                ],
              ),
            ))
          : Center(
              child: SpinKitCircle(
                color: Color.fromARGB(208, 0, 0, 0),
                size: 50.0,
              ),
            ),
    );
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