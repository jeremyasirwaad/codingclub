import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/ClubEvents.dart';
import '../Components/Drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: ListView(
            padding: EdgeInsets.only(
                // left: 16,
                // right: 16,
                // top: 22,
                ),
            children: [
              ClubeventCard(
                  "https://pluralsight2.imgix.net/paths/images/javascript-542e10ea6e.png",
                  "19 Aug 23",
                  "This is a Coding Club Javascript contest, I would love you guys to participate in the same without fail ",
                  "Javascript Contest"),
              ClubeventCard(
                  "https://gyanveda.in/wp-content/uploads/2021/05/C-Programming-1.png",
                  "20 Sep 23",
                  "C++ Advanced Programing Course will be handled on Friday of This month. I cordially invite you all to attend this event",
                  "C++ Course"),
              ClubeventCard(
                  "https://w7.pngwing.com/pngs/18/497/png-transparent-black-and-blue-atom-icon-screenshot-react-javascript-responsive-web-design-github-angularjs-github-logo-electric-blue-signage.png",
                  "20 Oct 23",
                  "React Development Bootcamp",
                  "React Dev"),
              // ClubeventCard(""),
              // ClubeventCard(""),
              // ClubeventCard(""),
              // ClubeventCard(""),
              // ClubeventCard(""),
              // ClubeventCard(""),
            ]),
      ),
    );
  }
}
