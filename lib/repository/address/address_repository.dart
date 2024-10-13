import 'package:my_app/model/address_model.dart';

abstract class AddressRepository {
  Future<void> addAddress(dynamic body);

  Future<List<AddressModel>> getAddressList();



  Future<void> deleteAddress(String id);
}
