class RestaurantModel {
  String? sId;
  String? title;
  String? address;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RestaurantModel(
      {this.sId,
      this.title,
      this.address,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});
      
  RestaurantModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    address = json['address'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['address'] = address;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
