import 'package:codingclub/Components/Drawer.dart';
import 'package:codingclub/Pages/GctNewsInnerPage.dart';

import '../Pages/EventsDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GctNewsCard extends StatefulWidget {
  GctNewsCard(this.NewsTitle, this.NewsFlyer, this.NewsDesc, this.NewsData);
  final String NewsTitle;
  final String NewsFlyer;
  final String NewsDesc;
  final String NewsData;

  @override
  State<GctNewsCard> createState() => _GctNewsCardState();
}

class _GctNewsCardState extends State<GctNewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GctNewsInnerPage(widget.NewsTitle,
                  widget.NewsFlyer, widget.NewsDesc, widget.NewsData),
            ),
          );
        },
        child: Card(
            elevation: 8,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              height: 310,
              width: double.infinity,
              child: Column(children: [
                Container(
                  height: 210,
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                    child: Image.network(widget.NewsFlyer),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  height: 100,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.NewsTitle,
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        Text(
                          widget.NewsDesc + " - READ MORE",
                          style: GoogleFonts.notoSerif(
                              color: Color.fromARGB(255, 111, 111, 111),
                              fontSize: 14),
                        )
                        // Positioned(
                        //     right: 25,
                        //     child: Text(
                        //       "19 June 23",
                        //       style: GoogleFonts.notoSerif(
                        //           color: Color.fromARGB(255, 111, 111, 111),
                        //           fontSize: 14),
                        //     ))
                      ]),
                )
              ]),
            )),
      ),
    );
  }
}
