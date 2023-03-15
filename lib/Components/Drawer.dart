import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CusDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.asset("assets/images/logo.jpeg", height: 100, width: 100,),
            Row(
              children: [
                
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    "Coding Club",
                    style: GoogleFonts.notoSerif(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 29),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    " GCT",
                    style: GoogleFonts.notoSerif(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 208, 0),
                        fontSize: 29),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: FaIcon(FontAwesomeIcons.code)),
                Text(
                  "Club Events",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: FaIcon(FontAwesomeIcons.newspaper)),
                Text(
                  "GCT News",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.calendarCheck)),
                Text(
                  "GCT Schedule",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.registered)),
                Text(
                  "Join Coding Club",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                )
              ],
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
