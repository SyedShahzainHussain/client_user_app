import 'package:my_app/abstract/base_config.dart';

class DevConfig extends BaseConfig {
  @override
  String get apiHost => "192.168.3.114:3000/";

  @override
  bool get useHttps => false;
}
