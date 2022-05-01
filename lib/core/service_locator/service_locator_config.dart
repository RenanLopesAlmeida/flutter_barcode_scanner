import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator_config.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void _configureDependencies(GetIt getIt) => $initGetIt(getIt);

class ServiceLocatorConfig {
  static final provide = GetIt.instance;

  const ServiceLocatorConfig._();

  static void init() {
    final getIt = provide;

    _configureDependencies(getIt);
  }
}
