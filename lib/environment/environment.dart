import 'package:my_app/abstract/base_config.dart';
import 'package:my_app/config_class/dev_config.dart';
import 'package:my_app/config_class/prod_config.dart';

class Environment {
  static final Environment _singleton = Environment._interval();

  Environment._interval();

  factory Environment() {
    return _singleton;
  }

  BaseConfig? baseConfig;
  static String selectedEnvironment = '';

  static const String dev = "dev";
  static const String prod = "prod";

  initConfig(String enviroment) {
    baseConfig = _getConfig(enviroment);
  }

  _getConfig(String environment) {
    switch (environment) {
      case Environment.dev:
        selectedEnvironment = environment;
        return DevConfig();
      case Environment.prod:
        selectedEnvironment = environment;
        return ProdConfig();
      default:
        selectedEnvironment = Environment.dev;
        return DevConfig();
    }
  }

}
