import 'dart:convert';
import 'package:codingclub/model/EventsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/ClubEvents.dart';
import '../Components/Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './Constants.dart' as Constants;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<EventData> _Events = [];
  bool isloading = true;

  Future<dynamic> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('${Constants.ProductionLink}/api/events'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      _Events = EventsModel.fromJson(datadart).data!;
      print(_Events[0].attributes!.appPoster);
      setState(() {
        isloading = false;
      });
      // print(_schedules!.length);
    } else {
      print("Null detectded");

      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchAlbum();
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
          title: Text("Club Events",
              style: GoogleFonts.notoSerif(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22))),
      drawer: CusDrawer(),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: !isloading
            ? ListView(
                padding: EdgeInsets.only(
                    // left: 16,
                    // right: 16,
                    // top: 22,
                    ),
                children: [
                    ...List.generate(
                        _Events.length,
                        (index) => ClubeventCard(
                            _Events[index].attributes!.appPoster as String,
                            _Events[index].attributes!.appShortDescription
                                as String,
                            _Events[index].attributes!.appEventDate as String,
                            _Events[index].attributes!.appTitle as String,
                            _Events[index].attributes!.appEventData as String,
                            _Events[index]
                                .attributes!
                                .appResgisterationGformLink as String))
                  ])
            : Center(
                child: SpinKitCircle(
                  color: Color.fromARGB(208, 0, 0, 0),
                  size: 50.0,
                ),
              ),
      ),
    );
  }
}
