import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/ClubEvents.dart';
import '../Components/Drawer.dart';
import '../firebase_analytics.dart';

class EventsDetails extends StatefulWidget {
  EventsDetails(this.imagesrc, this.app_event_data,
      this.appResgisterationGformLink, this.title, this.type, this.isOpen);
  final String imagesrc;
  final String type;
  // ignore: non_constant_identifier_names
  final String app_event_data;
  final String title;
  final String appResgisterationGformLink;
  final bool isOpen;

  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logevent();
  }

  void _logevent() async {
    await Analytics.analytics.logEvent(
      name: "Viewed ${Type}",
      parameters: <String, dynamic>{
        'title': widget.title,
      },
    );
  }

  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      bottomNavigationBar: ClipRRect(
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        child: GestureDetector(
          onTap: () {
            if (widget.isOpen == true) {
              _launchInBrowser(Uri.parse(widget.appResgisterationGformLink));
            }
          },
          child: Container(
            height: 50,
            color: widget.isOpen
                ? Color.fromARGB(255, 122, 34, 255)
                : Color.fromARGB(255, 255, 67, 54),
            child: Center(
              child: Text(
                widget.isOpen == true
                    ? widget.type == "event"
                        ? "Register"
                        : "Interested ?"
                    : "Registeration Closed",
                style: GoogleFonts.notoSerif(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20),
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
            widget.type == 'event' ? "Club Events" : "Job Opportunities",
            style: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22),
          )),
      // drawer: CusDrawer(),
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
                  widget.title,
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
