abstract class RedirectLauncher {
  Future<void> launchURL(String url);
}

class AppRedirectLauncher implements RedirectLauncher {
  @override
  Future<void> launchURL(String url) async {}
}
