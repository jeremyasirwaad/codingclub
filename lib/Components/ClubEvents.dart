import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubeventCard extends StatefulWidget {
  ClubeventCard(this.imagesrc, this.date, this.discription, this.title);
  final String imagesrc;
  final String date;
  final String discription;
  final String title;

  @override
  State<ClubeventCard> createState() => _ClubeventCardState();
}

class _ClubeventCardState extends State<ClubeventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                        fontSize: 19),
                  ),
                  Text(
                    widget.date,
                    style: GoogleFonts.notoSerif(
                        color: Color.fromARGB(255, 111, 111, 111),
                        fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.discription,
                    style: GoogleFonts.notoSerif(
                        color: Color.fromARGB(255, 111, 111, 111),
                        fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Read More",
                    style: GoogleFonts.notoSerif(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
                  ),
                  SizedBox(height: 10),
                ]),
          )
        ]),
      ),
    );
  }
}
