import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert';
import '../model/GctShedulesmodel.dart';

import 'package:google_fonts/google_fonts.dart';

import '../Components/Drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

class GctCalender extends StatefulWidget {
  const GctCalender({super.key});

  @override
  LoadDataFromGoogleSheetState createState() => LoadDataFromGoogleSheetState();
}

class LoadDataFromGoogleSheetState extends State<GctCalender> {
  MeetingDataSource? events;
  final List<Color> _colorCollection = <Color>[];
  List<Data>? _schedules = [];

  Future<dynamic> fetchAlbum() async {
    final response = await http.get(
      Uri.parse(
          'https://script.google.com/macros/s/AKfycbzmvTKearqzyY7hECy1YdWcJ3JARmkMw236df2SzgqWImz4kh5ti6-DnnLj7aMivM70/exec'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      _schedules = GctSchedulesmodel.fromJson(datadart).data;
      // print(_schedules!.length);
    } else {
      print("Null detectded");

      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // fetchAlbum();
    _initializeEventColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              toolbarHeight: 70,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "GCT Calender",
                style: GoogleFonts.notoSerif(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 22),
              )),
          drawer: CusDrawer(),
          body: SafeArea(
              child: Container(
            child: FutureBuilder(
              future: getDataFromGoogleSheet(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return SafeArea(
                      child: Container(
                    child: SfCalendar(
                      view: CalendarView.schedule,
                      monthViewSettings:
                          const MonthViewSettings(showAgenda: true),
                      dataSource: MeetingDataSource(snapshot.data),
                      initialDisplayDate: snapshot.data[0].from,
                    ),
                  ));
                } else {
                  return Container(
                    child: const Center(
                      child: SpinKitCircle(
                        color: Color.fromARGB(208, 0, 0, 0),
                        size: 50.0,
                      ),
                    ),
                  );
                }
              },
            ),
          ))),
    );
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  Future<List<Meeting>> getDataFromGoogleSheet() async {
    Response data = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbzmvTKearqzyY7hECy1YdWcJ3JARmkMw236df2SzgqWImz4kh5ti6-DnnLj7aMivM70/exec"),
    );
    print(data.body);

    var datadart = jsonDecode(data.body);
    _schedules = GctSchedulesmodel.fromJson(datadart).data;
    // print(jsonAppData);
    final List<Meeting> appointmentData = [];
    final Random random = Random();
    // print(jsonAppData);

    for (var data in _schedules!) {
      // print(data);
      Meeting meetingData = Meeting(
        eventName: data.eventname,
        from: _convertDateFromString(data.starttime.toString()),
        to: _convertDateFromString(data.endtime.toString()),
        background: _colorCollection[random.nextInt(9)],
      );
      // print(meetingData.from);
      appointmentData.add(meetingData);
    }
    print(appointmentData);
    return appointmentData;
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting(
      {this.eventName = '',
      required this.from,
      required this.to,
      this.background,
      this.isAllDay = false});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
}
