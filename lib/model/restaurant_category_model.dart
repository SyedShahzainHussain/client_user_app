class RestaurantCategoryModel {
  String? sId;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RestaurantCategoryModel(
      {this.sId, this.title, this.createdAt, this.updatedAt, this.iV});

  RestaurantCategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
