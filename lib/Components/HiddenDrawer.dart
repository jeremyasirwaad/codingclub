import 'package:codingclub/Pages/GctCalender.dart';
import 'package:codingclub/Pages/GctNews.dart';
import 'package:codingclub/Pages/HomePage.dart';
import 'package:codingclub/Pages/JobOpportunities.dart';
import 'package:codingclub/Pages/JoinCodingClub.dart';
import 'package:codingclub/Pages/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key, this.page = 0});
  final int page;

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Club Events",
            baseStyle: GoogleFonts.notoSerif(
                color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
            selectedStyle: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
          ),
          const HomePage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "GCT News",
            baseStyle: GoogleFonts.notoSerif(
                // fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
            selectedStyle: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
          ),
          const GctNews()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Job Opportunities",
            baseStyle: GoogleFonts.notoSerif(
                // fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
            selectedStyle: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
          ),
          const JobOpportunities()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Annual Schedule",
            baseStyle: GoogleFonts.notoSerif(
                // fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
            selectedStyle: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
          ),
          const GctCalender()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Daily Quiz",
            baseStyle: GoogleFonts.notoSerif(
                // fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
            selectedStyle: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
          ),
          const Quiz()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Join Coding Club",
            baseStyle: GoogleFonts.notoSerif(
                // fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
            selectedStyle: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16),
          ),
          const JoinCodingClub()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color.fromARGB(255, 247, 204, 77),
      screens: _pages,
      leadingAppBar: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      initPositionSelected: widget.page,
      elevationAppBar: 0,
      backgroundColorAppBar: Colors.white,
      styleAutoTittleName: GoogleFonts.notoSerif(
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 22),
      slidePercent: 50,
    );
  }
}
