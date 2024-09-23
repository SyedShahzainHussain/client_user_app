import 'package:my_app/model/product_model.dart';

class CartItem {
  String? sId;
  String? title;
  String? description;
  int? price;
  String? category;
  String? brand;
  String image;
  int quantity;
  List<Toppings>? selectedToppings;

  CartItem({
    required this.sId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.brand,
    required this.image,
    required this.quantity,
    this.selectedToppings = const [],
  });

  // Convert a CartItem into a Map. The keys must correspond to the JSON keys.
  Map<String, dynamic> toJson() {
    return {
      'sId': sId,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'brand': brand,
      'image': image,
      'quantity': quantity,
      'selectedToppings':
          selectedToppings?.map((topping) => topping.toJson()).toList(),
    };
  }

  // Create a CartItem from a Map. The keys must correspond to the JSON keys.
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      sId: json['sId'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      brand: json['brand'],
      image: json['image'],
      quantity: json['quantity'],
      selectedToppings: (json['selectedToppings'] as List<dynamic>?)
          ?.map((topping) => Toppings.fromJson(topping))
          .toList(),
    );
  }
}
