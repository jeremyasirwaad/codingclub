import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:codingclub/Pages/HomePage.dart';
import 'package:codingclub/model/AppUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_installer/app_installer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './Constants.dart' as Constants;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForUpadates();
  }

  _checkForUpadates() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    final response = await http.get(
      Uri.parse('${Constants.ProductionLink}/api/app-update'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      UpdateData updateinfo = appupdate.fromJson(datadart).data!;
      if (version != updateinfo.attributes!.version) {
        print("Different version");
        showAlertDialogloading(
            context,
            updateinfo.attributes!.apklink as String,
            updateinfo.attributes!.version as String);
        // showAlertDialog(context, updateinfo.attributes!.version as String,
        //     updateinfo.attributes!.apklink as String, download, _progress);
      } else {
        _navigateToHome();
      }
    } else {
      print(response);
      print("Null detectded");
      throw Exception('Failed to load album');
    }
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: HomePage()));
  }

  Future download(String url) async {
    PermissionStatus storageStatus = await Permission.storage.request();
    if (storageStatus == PermissionStatus.granted) {
      print("granted");
    }
    if (storageStatus == PermissionStatus.denied) {
      print("denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    FileDownloader.downloadFile(
        url: url,
        onProgress: (fileName, progress) => {
              setState(() {
                _progress = progress;
              }),
            },
        onDownloadCompleted: (path) =>
            {print("File Downloaded:" + path), OpenFile.open(path)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 280,
              width: 280,
            ),
          ],
        )),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String version, String url,
    Function download, double _progress) {
  // set up the button
  Widget okButton = TextButton(
    style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(255, 208, 0, 1),
        onPrimary: Colors.black,
        textStyle: TextStyle(color: Colors.black)),
    child: Text(
      "Download",
      style: GoogleFonts.notoSerif(fontSize: 14),
    ),
    onPressed: () {
      download(url);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Update Available - " + version,
      style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    content: Text(
        "Update is Available, download and install to continue using the app.",
        style: GoogleFonts.notoSerif(fontSize: 16)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogloading(
  BuildContext context,
  String url,
  String version,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String buttontext = "Download";
      String maintext = "Update Available - ";
      String subtext =
          "Update is Available, download and install to continue using the app.";
      double _progress = 0.0;
      bool showprog = false;
      bool downloaded = false;
      String pathv = "";
      bool btnstatus = true;

      return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
                title: Text(
                  maintext + version,
                  style: GoogleFonts.notoSerif(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                content: Container(
                    child: !showprog
                        ? Text(subtext,
                            style: GoogleFonts.notoSerif(fontSize: 16))
                        : new CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 5.0,
                            percent: _progress / 100,
                            center: new Text("${_progress.toString()}%"),
                            progressColor: Color.fromRGBO(255, 208, 0, 1),
                          )),
                actions: [
                  !downloaded
                      ? btnstatus
                          ? TextButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(255, 208, 0, 1),
                                  onPrimary: Colors.black,
                                  textStyle: TextStyle(color: Colors.black)),
                              child: Text(
                                buttontext,
                                style: GoogleFonts.notoSerif(fontSize: 16),
                              ),
                              onPressed: () async {
                                setState(() {
                                  buttontext = "Downloading";
                                  btnstatus = false;
                                });
                                PermissionStatus storageStatus =
                                    await Permission.storage.request();
                                if (storageStatus == PermissionStatus.granted) {
                                  print("granted");
                                }
                                if (storageStatus == PermissionStatus.denied) {
                                  print("denied");
                                }
                                if (storageStatus ==
                                    PermissionStatus.permanentlyDenied) {
                                  openAppSettings();
                                }

                                FileDownloader.downloadFile(
                                    url: url,
                                    onProgress: (fileName, progress) => {
                                          setState(() {
                                            maintext = "Downloading - ";
                                            showprog = true;
                                            _progress = progress;
                                          }),
                                        },
                                    onDownloadCompleted: (path) => {
                                          print("File Downloaded:" + path),
                                          setState(() {
                                            btnstatus = true;
                                            subtext =
                                                "Click Install Below to Update the app";
                                            showprog = false;
                                            pathv = path;
                                            downloaded = true;
                                            maintext = "Install Update - ";
                                          })
                                        });
                              },
                            )
                          : Container()
                      : TextButton(
                          onPressed: () {
                            AppInstaller.installApk(pathv);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(255, 208, 0, 1),
                              onPrimary: Colors.black,
                              textStyle: TextStyle(color: Colors.black)),
                          child: Text(
                            "Install",
                            style: GoogleFonts.notoSerif(fontSize: 16),
                          ),
                        ),
                ],
              ));
    },
  );
}
