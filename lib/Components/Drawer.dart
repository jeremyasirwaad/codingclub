import 'package:codingclub/Pages/GctCalender.dart';
import 'package:codingclub/Pages/GctNews.dart';
import 'package:codingclub/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Pages//JoinCodingClub.dart';

class CusDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 170,
              width: 170,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Text(
                    "Coding Club",
                    style: GoogleFonts.notoSerif(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Text(
                    " GCT",
                    style: GoogleFonts.notoSerif(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 208, 0, 1),
                        fontSize: 24),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                // color: Colors.amber,
                height: 70,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: FaIcon(FontAwesomeIcons.code)),
                    Text(
                      "Club Events",
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GctNews(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 70,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.newspaper)),
                    Text(
                      "GCT News",
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GctCalender(),
                  ),
                );
              },
              child: Container(
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.calendarCheck)),
                    Text(
                      "Annual Schedule",
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinCodingClub(),
                  ),
                );
                // print("hello");
              },
              child: Container(
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.registered)),
                    Text(
                      "Join Coding Club",
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
