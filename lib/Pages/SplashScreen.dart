import 'package:codingclub/Components/HiddenDrawer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final double _progress = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
    // _checkForUpadates();
  }

  // _checkForUpadates() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String version = packageInfo.version;

  //   final response = await http.get(
  //     Uri.parse('${Constants.ProductionLink}/api/app-update'),
  //   );

  //   if (response.statusCode == 200) {
  //     var datadart = jsonDecode(response.body);
  //     UpdateData updateinfo = appupdate.fromJson(datadart).data!;
  //     if (version != updateinfo.attributes!.version) {
  //       print("Different version");
  //       showAlertDialogloading(
  //           context,
  //           updateinfo.attributes!.apklink as String,
  //           updateinfo.attributes!.version as String);
  //       // showAlertDialog(context, updateinfo.attributes!.version as String,
  //       //     updateinfo.attributes!.apklink as String, download, _progress);
  //     } else {
  //       _navigateToHome();
  //     }
  //   } else {
  //     print(response);
  //     print("Null detectded");
  //     throw Exception('Failed to load album');
  //   }
  // }

  _navigateToHome() async {
    PermissionStatus Notificationstatus =
        await Permission.notification.request();
    if (Notificationstatus.isGranted) {
      await Future.delayed(const Duration(milliseconds: 3000), () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: const HiddenDrawer()));
      });
    }

    if (Notificationstatus.isDenied) {
      print("denied");
      showAlertDialog(context);
    }

    if (Notificationstatus.isPermanentlyDenied) {
      print(" permently denied");
      showAlertDialog(context);
    }
  }

  // Future download(String url) async {
  //   PermissionStatus storageStatus = await Permission.storage.request();
  //   if (storageStatus == PermissionStatus.granted) {
  //     print("granted");
  //   }
  //   if (storageStatus == PermissionStatus.denied) {
  //     print("denied");
  //   }
  //   if (storageStatus == PermissionStatus.permanentlyDenied) {
  //     openAppSettings();
  //   }

  //   FileDownloader.downloadFile(
  //       url: url,
  //       onProgress: (fileName, progress) => {
  //             setState(() {
  //               _progress = progress;
  //             }),
  //           },
  //       onDownloadCompleted: (path) =>
  //           {print("File Downloaded:" + path), OpenFile.open(path)});
  // }

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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
        textStyle: const TextStyle(color: Colors.black)),
    child: Text(
      "Okay",
      style: GoogleFonts.notoSerif(fontSize: 14),
    ),
    onPressed: () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: const HiddenDrawer()));
    },
  );

  Widget okButton2 = TextButton(
    style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: const Color.fromRGBO(255, 208, 0, 1),
        textStyle: const TextStyle(color: Colors.black)),
    child: Text(
      "Enable",
      style: GoogleFonts.notoSerif(fontSize: 14),
    ),
    onPressed: () {
      openAppSettings();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(
        "Notication Denied",
        style: GoogleFonts.notoSerif(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Text("Enable Notication For Better Experience !",
          style: GoogleFonts.notoSerif(fontSize: 16)),
      actions: [okButton2, okButton]);

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// showAlertDialogloading(
//   BuildContext context,
//   String url,
//   String version,
// ) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       String buttontext = "Download";
//       String maintext = "Update Available - ";
//       String subtext =
//           "Update is Available, download and install to continue using the app. \n Kindly allow storage permissions";
//       double _progress = 0.0;
//       bool showprog = false;
//       bool downloaded = false;
//       String pathv = "";
//       bool btnstatus = true;

//       return StatefulBuilder(
//           builder: (context, setState) => AlertDialog(
//                 title: Text(
//                   maintext + version,
//                   style: GoogleFonts.notoSerif(
//                       fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 content: Container(
//                     child: !showprog
//                         ? Text(subtext,
//                             style: GoogleFonts.notoSerif(fontSize: 16))
//                         : new CircularPercentIndicator(
//                             radius: 40.0,
//                             lineWidth: 5.0,
//                             percent: _progress / 100,
//                             center: new Text("${_progress.toString()}%"),
//                             progressColor: Color.fromRGBO(255, 208, 0, 1),
//                           )),
//                 actions: [
//                   !downloaded
//                       ? btnstatus
//                           ? TextButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: Color.fromRGBO(255, 208, 0, 1),
//                                   onPrimary: Colors.black,
//                                   textStyle: TextStyle(color: Colors.black)),
//                               child: Text(
//                                 buttontext,
//                                 style: GoogleFonts.notoSerif(fontSize: 16),
//                               ),
//                               onPressed: () async {
//                                 PermissionStatus storageStatus =
//                                     await Permission.storage.request();

//                                 PermissionStatus appinstallStatus =
//                                     await Permission.requestInstallPackages
//                                         .request();

//                                 print(storageStatus);

//                                 if (storageStatus == PermissionStatus.granted &&
//                                     appinstallStatus ==
//                                         PermissionStatus.granted) {
//                                   print("granted");
//                                 }
//                                 if (storageStatus == PermissionStatus.denied &&
//                                     appinstallStatus ==
//                                         PermissionStatus.denied) {
//                                   print("denied");
//                                 }
//                                 if (storageStatus ==
//                                     PermissionStatus.permanentlyDenied) {
//                                   openAppSettings();
//                                 }

//                                 if (appinstallStatus ==
//                                     PermissionStatus.permanentlyDenied) {
//                                   openAppSettings();
//                                 }
//                                 setState(() {
//                                   buttontext = "Downloading";
//                                   btnstatus = false;
//                                 });
//                                 if (storageStatus == PermissionStatus.granted) {
//                                   FileDownloader.downloadFile(
//                                       url: url,
//                                       onProgress: (fileName, progress) => {
//                                             setState(() {
//                                               maintext = "Downloading - ";
//                                               showprog = true;
//                                               _progress = progress;
//                                             }),
//                                           },
//                                       onDownloadCompleted: (path) async => {
//                                             print("File Downloaded:" + path),
//                                             setState(() {
//                                               btnstatus = true;
//                                               subtext =
//                                                   "Click Install Below to Update the app";
//                                               showprog = false;
//                                               pathv = path;
//                                               downloaded = true;
//                                               maintext = "Install Update - ";
//                                             }),
//                                             await Analytics.analytics.logEvent(
//                                                 name:
//                                                     "Downloaded Update$version")
//                                           });
//                                 }
//                               },
//                             )
//                           : Container()
//                       : TextButton(
//                           onPressed: () {
//                             AppInstaller.installApk(pathv);
//                           },
//                           style: ElevatedButton.styleFrom(
//                               primary: Color.fromRGBO(255, 208, 0, 1),
//                               onPrimary: Colors.black,
//                               textStyle: TextStyle(color: Colors.black)),
//                           child: Text(
//                             "Install",
//                             style: GoogleFonts.notoSerif(fontSize: 16),
//                           ),
//                         ),
//                 ],
//               ));
//     },
//   );
// }