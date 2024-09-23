class ProductModel {
  String? status;
  int? results;
  List<Data>? data;

  ProductModel({this.status, this.results, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['results'] = results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
  String? brand;
  int? quantity;
  List<String>? images;
  String? totalrating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Ratings>? ratings;
  List<Toppings>? toppings;

  Data(
      {this.sId,
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
      this.ratings,
      this.toppings});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    brand = json['brand'];
    quantity = json['quantity'];
    images = json['images'].cast<String>();
    totalrating = json['totalrating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
    if (json['toppings'] != null) {
      toppings = <Toppings>[];
      json['toppings'].forEach((v) {
        toppings!.add(Toppings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['brand'] = brand;
    data['quantity'] = quantity;
    data['images'] = images;
    data['totalrating'] = totalrating;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    if (toppings != null) {
      data['toppings'] = toppings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  
   double getAverageRating() {
    if (ratings == null || ratings!.isEmpty) {
      return 0.0;
    }

    int totalStars =
        ratings!.fold(0, (sum, rating) => sum + (rating.star ?? 0));
    return totalStars / ratings!.length;
  }
}

class Ratings {
  int? star;
  String? comment;
  String? postedby;
  String? sId;

  Ratings({this.star, this.comment, this.postedby, this.sId});

  Ratings.fromJson(Map<String, dynamic> json) {
    star = json['star'];
    comment = json['comment'];
    postedby = json['postedby'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['star'] = star;
    data['comment'] = comment;
    data['postedby'] = postedby;
    data['_id'] = sId;
    return data;
  }
  
}

class Toppings {
  String? sId;
  String? title;
  String? image;
  String? category;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? price;

  Toppings(
      {this.sId,
      this.title,
      this.image,
      this.category,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.price});

  Toppings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['image'] = image;
    data['category'] = category;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['price'] = price;
    return data;
  }
}
