class OrderModel {
  PaymentIntent? paymentIntent;
  String? sId;
  List<Products>? products;
  String? orderStatus;
  String? orderby;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OrderModel({
    this.paymentIntent,
    this.sId,
    this.products,
    this.orderStatus,
    this.orderby,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  // JSON serialization
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      paymentIntent: json['paymentIntent'] != null ? PaymentIntent.fromJson(json['paymentIntent']) : null,
      sId: json['_id'],
      products: (json['products'] as List?)?.map((v) => Products.fromJson(v)).toList(),
      orderStatus: json['orderStatus'],
      orderby: json['orderby'],
      address: json['address'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  // toJson Method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentIntent != null) {
      data['paymentIntent'] = paymentIntent!.toJson();
    }
    data['_id'] = sId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['orderStatus'] = orderStatus;
    data['orderby'] = orderby;
    data['address'] = address;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}


class PaymentIntent {
  String? id;
  String? status;
  int? amount;
  String? currency;

  PaymentIntent({this.id, this.status, this.amount, this.currency});

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'],
      status: json['status'],
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'amount': amount,
      'currency': currency,
    };
  }
}

class Products {
  Product? product;
  int? count;
  Topping? topping;
  Topping? sidetopping;
  String? sId;

  Products({
    this.product,
    this.count,
    this.topping,
    this.sidetopping,
    this.sId,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      count: json['count'],
      topping: json['topping'] != null ? Topping.fromJson(json['topping']) : null,
      sidetopping: json['sidetopping'] != null ? Topping.fromJson(json['sidetopping']) : null,
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product?.toJson(),
      'count': count,
      'topping': topping?.toJson(),
      'sidetopping': sidetopping?.toJson(),
      '_id': sId,
    };
  }
}

class Product {
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? price;
  String? category;
  String? brand;
  int? quantity;
  List<String>? images;
  String? totalrating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? address;

  Product({
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.brand,
    this.quantity,
    this.images,
    this.totalrating,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.address,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sId: json['_id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      brand: json['brand'],
      quantity: json['quantity'],
      images: List<String>.from(json['images']),
      totalrating: json['totalrating'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'slug': slug,
      'description': description,
      'price': price,
      'category': category,
      'brand': brand,
      'quantity': quantity,
      'images': images,
      'totalrating': totalrating,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'address': address,
    };
  }
}
class Topping {
  String? sId;
  String? title;
  String? image;
  String? category;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? price;

  Topping({
    this.sId,
    this.title,
    this.image,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      sId: json['_id'],
      title: json['title'],
      image: json['image'],
      category: json['category'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'image': image,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'price': price,
    };
  }
}

