import 'package:codingclub/Components/Skeleton.dart';

import '../Pages/EventsDetails.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubeventCard extends StatefulWidget {
  const ClubeventCard(
      this.imagesrc,
      this.date,
      this.discription,
      this.title,
      this.app_event_data,
      this.appResgisterationGformLink,
      this.type,
      this.isOpen, {super.key});
  final String imagesrc;
  final String date;
  final String discription;
  final String title;
  final String app_event_data;
  final String appResgisterationGformLink;
  final String type;
  final bool isOpen;

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
            builder: (context) => EventsDetails(
                widget.imagesrc,
                widget.app_event_data,
                widget.appResgisterationGformLink,
                widget.title,
                widget.type,
                widget.isOpen),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          // height: 130,
          width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CachedNetworkImage(
                height: 110,
                width: 110,
                imageUrl: widget.imagesrc,
                placeholder: (context, url) => const Skeleton(
                      height: 110,
                      width: 110,
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.notoSerif(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Text(
                      widget.date,
                      style: GoogleFonts.notoSerif(
                          color: const Color.fromARGB(255, 111, 111, 111),
                          fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.discription,
                      style: GoogleFonts.notoSerif(
                          color: const Color.fromARGB(255, 111, 111, 111),
                          fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Read More",
                      style: GoogleFonts.notoSerif(
                          color: const Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
