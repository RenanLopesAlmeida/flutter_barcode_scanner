import 'package:barcodes_flutter_app/utils/app_redirect_launcher.dart';
import 'package:injectable/injectable.dart';

@module
abstract class UtilsCoreModule {
  @singleton
  RedirectLauncher redirectLauncher(
    AppRedirectLauncherUtil util,
  ) =>
      util;
}
