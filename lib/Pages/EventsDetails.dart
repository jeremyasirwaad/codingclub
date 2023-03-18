import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/ClubEvents.dart';
import '../Components/Drawer.dart';

class EventsDetails extends StatelessWidget {
  const EventsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Club Events",
            style: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 26),
          )),
      drawer: CusDrawer(),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  "JavaScript Coding Bootcamp ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 22),
                ),
              ),
              Image.network(
                "https://gyanveda.in/wp-content/uploads/2021/05/C-Programming-1.png",
                height: 210,
                width: 210,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("Date: 12-22-2022"),
                    Text("Time: 12:00pm"),
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
