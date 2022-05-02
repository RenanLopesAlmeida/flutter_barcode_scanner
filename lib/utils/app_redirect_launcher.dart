import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

abstract class RedirectLauncher {
  Future<void> launchURL(String url);
}

@singleton
class AppRedirectLauncherUtil implements RedirectLauncher {
  @override
  Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);

    if (!await launcher.launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
