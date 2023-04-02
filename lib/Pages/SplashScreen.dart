import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:codingclub/Pages/HomePage.dart';
import 'package:codingclub/model/AppUpdate.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import './Constants.dart' as Constants;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Donwload Completed");
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    _checkForUpadates();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  _checkForUpadates() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    final response = await http.get(
      Uri.parse('${Constants.DevelopmentLink}/api/app-update'),
    );

    if (response.statusCode == 200) {
      var datadart = jsonDecode(response.body);
      UpdateData updateinfo = appupdate.fromJson(datadart).data!;
      if (version != updateinfo.attributes!.version) {
        print("Different version");
        showAlertDialog(context, updateinfo.attributes!.version as String,
            updateinfo.attributes!.apklink as String, download);
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
    print("Clicked Download");
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

    if (await Permission.storage.isGranted) {
      print("Permission Granted");
      final baseStorage = await getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        saveInPublicStorage: true,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );

      if (taskId != null) {
        await OpenFile.open(baseStorage!.path + "/app-release.apk");
      }
    }
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

showAlertDialog(
    BuildContext context, String version, String url, Function download) {
  // set up the button
  Widget okButton = TextButton(
    style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(255, 208, 0, 1),
        onPrimary: Colors.black,
        textStyle: TextStyle(color: Colors.black)),
    child: Text(
      "Install",
      style: GoogleFonts.notoSerif(fontSize: 16),
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
      style: GoogleFonts.notoSerif(fontSize: 16),
    ),
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
