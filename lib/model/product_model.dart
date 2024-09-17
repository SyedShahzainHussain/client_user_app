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
  List<Ratings>? ratings;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
      this.ratings,
      this.createdAt,
      this.updatedAt,
      this.iV});

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
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
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
    data['brand'] = brand;
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
  String? sId;

  Ratings({this.star, this.comment, this.sId});

  Ratings.fromJson(Map<String, dynamic> json) {
    star = json['star'];
    comment = json['comment'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['star'] = star;
    data['comment'] = comment;
    data['_id'] = sId;
    return data;
  }
}
