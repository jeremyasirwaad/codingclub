import 'dart:async';
import 'dart:convert';
import 'package:codingclub/Pages/LeaderBoard.dart';
import 'package:codingclub/model/QuizModel.dart' as qm;
import 'package:codingclub/model/Quizuser.dart' as qu;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './Constants.dart' as Constants;
import 'package:shared_preferences/shared_preferences.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<qm.Data> _Quiz = [];
  bool isloading = true;
  int? checkboxValue;
  final TextEditingController _RollNo = TextEditingController();
  bool _isButtonVisible = false;

  bool checktime() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 10 || hour >= 18) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> fetchAlbum() async {
    final response = await http.get(
      Uri.parse(
          '${Constants.ProductionLink}/api/weekly-quizs?sort=quiz_id:desc'),
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

    if (_RollNo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
        content: Text('Enter Roll Number to Submit !',
            style: GoogleFonts.notoSerif(color: Colors.black, fontSize: 16)),
      ));
      return;
    }

    if (checkboxValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
        content: Text('Choose an answer to submit !',
            style: GoogleFonts.notoSerif(color: Colors.black, fontSize: 16)),
      ));
      return;
    }

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
      // appBar: AppBar(
      //     toolbarHeight: 70,
      //     iconTheme: IconThemeData(color: Colors.black),
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     title: Text("Daily Quiz",
      //         style: GoogleFonts.notoSerif(
      //             fontWeight: FontWeight.w600,
      //             color: Color.fromARGB(255, 0, 0, 0),
      //             fontSize: 22))),
      // drawer: CusDrawer(),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color.fromRGBO(255, 208, 0, 1),
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
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const LeaderBoard()));
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
      ),
      body: !isloading
          ? SingleChildScrollView(
              child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Question - ${_Quiz[_Quiz.length - 1].attributes!.quizId}",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSerif(
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _Quiz[_Quiz.length - 1].attributes!.question as String,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSerif(
                        color: const Color.fromARGB(255, 0, 0, 0), fontSize: 17),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(a) ${_Quiz[_Quiz.length - 1].attributes!.op1}",
                          style: GoogleFonts.notoSerif(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
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
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(b) ${_Quiz[_Quiz.length - 1].attributes!.op2}",
                          style: GoogleFonts.notoSerif(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
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
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(c) ${_Quiz[_Quiz.length - 1].attributes!.op3}",
                          style: GoogleFonts.notoSerif(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
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
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "(d) ${_Quiz[_Quiz.length - 1].attributes!.op4}",
                          style: GoogleFonts.notoSerif(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
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
                                  margin: const EdgeInsets.only(top: 40),
                                  child: Center(
                                    child: Text(
                                        "Correct Answer is ${getAnswer(int.parse(_Quiz[_Quiz.length - 1].attributes!.ans![2]))}",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.notoSerif(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                            fontSize: 17)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Stay tuned, Next Quiz at 10AM",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.notoSerif(
                                        color: Colors.black, fontSize: 15)),
                              ],
                            )
                          : Container()),
                  const SizedBox(
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
                                      if (value!.length != 10) {
                                        return '';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        label: Text("Roll Number"),
                                        prefixIcon: Icon(Icons.numbers),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: const Text(
                                    "* Roll No will be used for leaderboard",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // padding: EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black, backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
                                        textStyle:
                                            const TextStyle(color: Colors.black)),
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
                          : SizedBox(
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image.network(
                                            "https://media.tenor.com/0AVbKGY_MxMAAAAM/check-mark-verified.gif"),
                                      ),
                                    ),
                                    Text("Quiz Attended",
                                        style: GoogleFonts.notoSerif(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Text("Answers Will be out by 6pm",
                                        style: GoogleFonts.notoSerif(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ))
                                  ]),
                            )
                      : Container(),
                ],
              ),
            ))
          : const Center(
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
        foregroundColor: Colors.black, backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
        textStyle: const TextStyle(color: Colors.black)),
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
        foregroundColor: Colors.black, backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
        textStyle: const TextStyle(color: Colors.black)),
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
