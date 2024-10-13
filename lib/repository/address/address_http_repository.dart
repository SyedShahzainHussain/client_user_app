import 'package:my_app/config/url.dart';
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/model/address_model.dart';
import 'package:my_app/repository/address/address_repository.dart';

class AddressHttpRepository extends AddressRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<void> addAddress(dynamic body) async {
    try {
      await baseApiServices.getPostApiResponse(Urls.address, body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AddressModel>> getAddressList() async {
    try {
      final response = await baseApiServices.getGetApiResponse(Urls.address);

      final data = response as List;
      return data.map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await baseApiServices.deletePostApiResponse(
        "${Urls.address}/$id",
      );
    } catch (e) {
      rethrow;
    }
  }
}
