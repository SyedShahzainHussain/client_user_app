import 'package:my_app/model/delivery_address_model.dart';

abstract class GooglePlaceApiHttpRepository {
  Future<DeleiveryAddressModel> getAddressDescription(String input,String sessionCode);
}