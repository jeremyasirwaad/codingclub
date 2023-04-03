import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/ClubEvents.dart';
import '../Components/Drawer.dart';

class EventsDetails extends StatefulWidget {
  EventsDetails(
      this.imagesrc, this.app_event_data, this.appResgisterationGformLink);
  final String imagesrc;
  // ignore: non_constant_identifier_names
  final String app_event_data;
  final String appResgisterationGformLink;
  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        child: GestureDetector(
          onTap: () async {
            print("Clicked");
            void _launchURL() async =>
                await launch(widget.appResgisterationGformLink);
          },
          child: Container(
            height: 50,
            color: Color.fromARGB(255, 122, 34, 255),
            child: Center(
              child: Text(
                "Register",
                style: GoogleFonts.notoSerif(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 22),
              ),
            ),
          ),
        ),
      ),
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
                fontSize: 22),
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
                widget.imagesrc,
                height: 210,
                width: 210,
              ),
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.all(10),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Text(
              //             "Venue: Main Auditorium",
              //             style: GoogleFonts.notoSerif(
              //                 fontWeight: FontWeight.w600,
              //                 color: Color.fromARGB(255, 0, 0, 0),
              //                 fontSize: 16),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Text(
              //             "Date: 12-22-2022",
              //             style: GoogleFonts.notoSerif(
              //                 fontWeight: FontWeight.w600,
              //                 color: Color.fromARGB(255, 0, 0, 0),
              //                 fontSize: 16),
              //           ),
              //           Text(
              //             "Time: 12:00pm",
              //             style: GoogleFonts.notoSerif(
              //                 fontWeight: FontWeight.w600,
              //                 color: Color.fromARGB(255, 0, 0, 0),
              //                 fontSize: 16),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Text(
              //             "Contact: 98343632220",
              //             style: GoogleFonts.notoSerif(
              //                 fontWeight: FontWeight.w600,
              //                 color: Color.fromARGB(255, 0, 0, 0),
              //                 fontSize: 16),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                widget.app_event_data,
                style: GoogleFonts.notoSerif(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
              ))
        ]),
      ),
    );
  }
}
