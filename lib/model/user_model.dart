class UserModel {
  String? message;
  String? token;
  User? user;

  UserModel({this.message, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? number;
  String? role;
  String? address;
  String? image;
  List<String>? wishlist;
  String? id;

  User(
      {this.sId,
      this.name,
      this.email,
      this.number,
      this.role,
      this.address,
      this.image,
      this.wishlist,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    role = json['role'];
    address = json['address'];
    image = json['image'];
    wishlist = json['wishlist'].cast<String>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['number'] = number;
    data['role'] = role;
    data['address'] = address;
    data['image'] = image;
    data['wishlist'] = wishlist;
    data['id'] = id;
    return data;
  }
}
