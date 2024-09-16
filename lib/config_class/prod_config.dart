import 'package:my_app/abstract/base_config.dart';

class ProdConfig extends BaseConfig{
  @override
  String get apiHost => "192.168.3.112:";

  @override
  bool get useHttps => false;

}