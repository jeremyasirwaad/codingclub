import '../Pages/EventsDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubeventCard extends StatefulWidget {
  ClubeventCard(this.imagesrc, this.date, this.discription, this.title,
      this.app_event_data, this.appResgisterationGformLink);
  final String imagesrc;
  final String date;
  final String discription;
  final String title;
  final String app_event_data;
  final String appResgisterationGformLink;

  @override
  State<ClubeventCard> createState() => _ClubeventCardState();
}

class _ClubeventCardState extends State<ClubeventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsDetails(widget.imagesrc,
                widget.app_event_data, widget.appResgisterationGformLink),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          // height: 130,
          width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.network(
              widget.imagesrc,
              height: 110,
              width: 110,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title as String,
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Text(
                      widget.date,
                      style: GoogleFonts.notoSerif(
                          color: Color.fromARGB(255, 111, 111, 111),
                          fontSize: 13),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.discription,
                      style: GoogleFonts.notoSerif(
                          color: Color.fromARGB(255, 111, 111, 111),
                          fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Read More",
                      style: GoogleFonts.notoSerif(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                    ),
                    SizedBox(height: 10),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
