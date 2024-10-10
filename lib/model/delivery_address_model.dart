class DeleiveryAddressModel {
  List<Predictions>? predictions;
  String? status;

  DeleiveryAddressModel({this.predictions, this.status});

  DeleiveryAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = <Predictions>[];
      json['predictions'].forEach((v) {
        predictions!.add(Predictions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predictions != null) {
      data['predictions'] = predictions!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Predictions {
  String? description;
  String? placeId;
  String? reference;
  List<String>? types;

  Predictions({this.description, this.placeId, this.reference, this.types});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
    reference = json['reference'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;

    data['place_id'] = placeId;
    data['reference'] = reference;

    data['types'] = types;
    return data;
  }
}
