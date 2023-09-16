import 'package:cached_network_image/cached_network_image.dart';
import 'package:codingclub/Components/Skeleton.dart';
import '../firebase_analytics.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GctNewsInnerPage extends StatefulWidget {
  const GctNewsInnerPage(
      this.NewsTitle, this.NewsFlyer, this.NewsDesc, this.NewsData, {super.key});
  final String NewsTitle;
  final String NewsFlyer;
  final String NewsDesc;
  final String NewsData;

  @override
  State<GctNewsInnerPage> createState() => _GctNewsInnerPageState();
}

class _GctNewsInnerPageState extends State<GctNewsInnerPage> {
  @override
  void initState() {
    super.initState();
    _logevent();
  }

  void _logevent() async {
    await Analytics.analytics.logEvent(
      name: "Viewed News",
      parameters: <String, dynamic>{
        'title': widget.NewsTitle,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "News",
            style: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 22),
          )),
      // drawer: CusDrawer(),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.NewsTitle,
              style: GoogleFonts.notoSerif(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 22),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              width: double.infinity,
              child: CachedNetworkImage(
                  imageUrl: widget.NewsFlyer,
                  placeholder: (context, url) => const Skeleton(
                        width: double.infinity,
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.NewsData,
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
