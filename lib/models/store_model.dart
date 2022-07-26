List<StoreModel> productsFromJson(dynamic str) =>
    List<StoreModel>.from((str).map((x) => StoreModel.fromJson(x)));

class StoreModel {
  late String? id;
  late String? Location;
  late String? Name;

  StoreModel(
    Map<dynamic, String> map, {
    this.id,
    this.Location,
    this.Name,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    Location = json["location"];
    Name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["location"] = Location;
    _data["name"] = Name;
    return _data;
  }
}
