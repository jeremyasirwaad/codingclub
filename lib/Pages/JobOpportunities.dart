import 'dart:convert';
import 'package:flutter/material.dart';
import '../Components/ClubEvents.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './Constants.dart' as Constants;
import '../model/JobOpportunitymodel.dart';

class JobOpportunities extends StatefulWidget {
  const JobOpportunities({Key? key}) : super(key: key);

  @override
  State<JobOpportunities> createState() => _JobOpportunitiesState();
}

class _JobOpportunitiesState extends State<JobOpportunities> {
  List<JobOpportunityData> _Events = [];
  bool isloading = true;

  Future<dynamic> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('${Constants.ProductionLink}/api/job-opportunities'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);

      setState(() {
        isloading = false;
        _Events = JobOpportunity.fromJson(datadart).data!;
      });
      // print(_schedules!.length);
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
      // appBar: AppBar(
      //     toolbarHeight: 70,
      //     iconTheme: IconThemeData(color: Colors.black),
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     title: Text("Job Opportunities",
      //         style: GoogleFonts.notoSerif(
      //             fontWeight: FontWeight.w600,
      //             color: Color.fromARGB(255, 0, 0, 0),
      //             fontSize: 22))),
      // drawer: CusDrawer(),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: !isloading
            ? ListView(children: [
                ...List.generate(
                    _Events.length,
                    (index) => ClubeventCard(
                        _Events[index].attributes!.jobPoster as String,
                        _Events[index].attributes!.jobShortDescription
                            as String,
                        _Events[index].attributes!.postingDate as String,
                        _Events[index].attributes!.jobTitle as String,
                        _Events[index].attributes!.eventData as String,
                        _Events[index].attributes!.contactlink as String,
                        "Job",
                        true)).reversed.toList()
              ])
            : const Center(
                child: SpinKitCircle(
                  color: Color.fromARGB(208, 0, 0, 0),
                  size: 50.0,
                ),
              ),
      ),
    );
  }
}
