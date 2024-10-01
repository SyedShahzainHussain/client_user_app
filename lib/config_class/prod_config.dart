import 'package:my_app/abstract/base_config.dart';

class ProdConfig extends BaseConfig{
  @override
  String get apiHost => "italybackend2.onrender.com/api/v1/";

  @override
  bool get useHttps => true;

}