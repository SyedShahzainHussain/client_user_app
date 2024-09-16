import 'package:my_app/abstract/base_config.dart';

class DevConfig extends BaseConfig {
  @override
  String get apiHost => "192.168.3.113:3000/api/v1/";

  @override
  bool get useHttps => false;
}
