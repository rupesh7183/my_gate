import 'package:url_launcher/url_launcher.dart';

class Utility{

  static launchUrlOnExternalBrowser(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
    try {
      await launch(url);
    } catch (e) {
      print(e);
    }
  }
}