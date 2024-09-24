class SideToppins {
  String? sId;
  String? title;
  String? image;
  String? category;
  int? price;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SideToppins(
      {this.sId,
      this.title,
      this.image,
      this.category,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SideToppins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    category = json['category'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['category'] = this.category;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
