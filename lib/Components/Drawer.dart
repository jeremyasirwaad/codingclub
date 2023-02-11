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
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: FaIcon(FontAwesomeIcons.adversal)),
                Text("Club Events"),
              ],
            ),
            Row(
              children: [
                Text("GCT News"),
              ],
            ),
            Row(
              children: [
                Text("GCT Schedule"),
              ],
            ),
            Row(
              children: [Text("Register for Coding Club")],
            )
          ],
        ),
      ),
    );
  }
}
