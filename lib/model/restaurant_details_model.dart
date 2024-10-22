class RestaurantDetailsModel {
  String? sId;
  String? title;
  String? address;
  String? category;
  String? image;
  List<Data>? products;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RestaurantDetailsModel({
    this.sId,
    this.title,
    this.address,
    this.category,
    this.image,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    address = json['address'];
    category = json['category'];
    image = json['image'];
    if (json['products'] != null) {
      products =
          (json['products'] as List).map((v) => Data.fromJson(v)).toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['address'] = address;
    data['category'] = category;
    data['image'] = image;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? price;
  String? category;
  String? address;
  int? quantity;
  List<String>? images;
  String? totalrating;
  List<Rating>? ratings;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.address,
    this.quantity,
    this.images,
    this.totalrating,
    this.ratings,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    address = json['address'];
    quantity = json['quantity'];
    images = (json['images'] as List<dynamic>).cast<String>();
    totalrating = json['totalrating'];
    if (json['ratings'] != null) {
      ratings =
          (json['ratings'] as List).map((v) => Rating.fromJson(v)).toList();
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['address'] = address;
    data['quantity'] = quantity;
    data['images'] = images;
    data['totalrating'] = totalrating;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Rating {
  String? userId;
  int? score;
  String? comment;

  Rating({this.userId, this.score, this.comment});

  Rating.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    score = json['score'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['score'] = score;
    data['comment'] = comment;
    return data;
  }
}
