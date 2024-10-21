
import 'package:my_app/data/network/base_api_services.dart';
import 'package:my_app/data/network/network_api_services.dart';
import 'package:my_app/repository/google_place_repository/google_place_http_repository.dart';

import '../../model/delivery_address_model.dart';

class GooglePlaceApiRepository extends GooglePlaceApiHttpRepository {
  final BaseApiServices baseApiServices = NetworkApiServices();

  @override
  Future<DeleiveryAddressModel> getAddressDescription(
      String input, String sessionCode) async {
    try {
      final response = await baseApiServices.getGetApiResponse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyAoSbver7G9emTgsZMM4RCAXt3z5pjauYE&sessionToken=$sessionCode");

      return DeleiveryAddressModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
