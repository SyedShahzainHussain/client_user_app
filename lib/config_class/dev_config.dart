import 'package:my_app/abstract/base_config.dart';

class DevConfig extends BaseConfig {
  @override
  String get apiHost => "itlayecommercebackend.onrender.com/api/v1/";

  @override
  bool get useHttps => true;
}