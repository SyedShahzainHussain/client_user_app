class BrandModel {
  String? sId;
  String? title;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BrandModel(
      {this.sId,
      this.title,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BrandModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
