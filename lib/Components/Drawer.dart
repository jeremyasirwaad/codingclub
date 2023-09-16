import 'package:codingclub/Pages/GctCalender.dart';
import 'package:codingclub/Pages/GctNews.dart';
import 'package:codingclub/Pages/HomePage.dart';
import 'package:codingclub/Pages/JobOpportunities.dart';
import 'package:codingclub/Pages/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Pages//JoinCodingClub.dart';

class CusDrawer extends StatelessWidget {
  const CusDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: ListView(
          children: [
            Container(
              child: Image.asset(
                "assets/images/logo.png",
                height: 170,
                width: 170,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Text(
                        "Coding Club",
                        style: GoogleFonts.notoSerif(
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Text(
                        " GCT",
                        style: GoogleFonts.notoSerif(
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(255, 208, 0, 1),
                            fontSize: 24),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
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
                            onPressed: () {},
                            icon: const FaIcon(FontAwesomeIcons.code)),
                        Text(
                          "Club Events",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                        builder: (context) => const GctNews(),
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
                            icon: const FaIcon(FontAwesomeIcons.newspaper)),
                        Text(
                          "GCT News",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                        builder: (context) => const JobOpportunities(),
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
                            icon: const FaIcon(FontAwesomeIcons.idCard)),
                        Text(
                          "Job Opportunities",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                        builder: (context) => const GctCalender(),
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
                            icon: const FaIcon(FontAwesomeIcons.calendarCheck)),
                        Text(
                          "Annual Schedule",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                        builder: (context) => const Quiz(),
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
                            icon: const FaIcon(FontAwesomeIcons.question)),
                        Text(
                          "Quiz",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                        builder: (context) => const JoinCodingClub(),
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
                            icon: const FaIcon(FontAwesomeIcons.registered)),
                        Text(
                          "Join Coding Club",
                          style: GoogleFonts.notoSerif(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
