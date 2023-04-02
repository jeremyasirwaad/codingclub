import 'dart:convert';
import 'package:codingclub/Components/Drawer.dart';
import 'package:codingclub/Components/GctNewsCard.dart';
import 'package:codingclub/model/NewsModel.dart';
import 'package:http/http.dart' as http;
import '../Pages/EventsDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GctNews extends StatefulWidget {
  GctNews({Key? key}) : super(key: key);

  @override
  State<GctNews> createState() => _GctNewsState();
}

class _GctNewsState extends State<GctNews> {
  List<NewsData> _News = [];
  bool isloading = true;

  Future<dynamic> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:1337/api/gct-newss'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      setState(() {
        isloading = false;
        _News = NewsModel.fromJson(datadart).data!;
      });
      print(_News[0].attributes!.appTitle as String);
    } else {
      print("Null detectded");
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "GCT News",
            style: GoogleFonts.notoSerif(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 26),
          )),
      drawer: CusDrawer(),
      body: !isloading
          ? ListView(children: [
              ...List.generate(
                _News.length,
                (index) => GctNewsCard(
                    _News[index].attributes!.appTitle as String,
                    _News[index].attributes!.appFlyer as String,
                    _News[index].attributes!.appDesc as String,
                    _News[index].attributes!.appData as String),
              ),
            ])
          : Center(
              child: SpinKitCircle(
                color: Color.fromARGB(208, 0, 0, 0),
                size: 50.0,
              ),
            ),
    );
  }
}
