import 'side_topping_repository.dart';

abstract class SideToppingApiRepository {
  Future<List<SideToppins>> getAllSideToppings();
}
