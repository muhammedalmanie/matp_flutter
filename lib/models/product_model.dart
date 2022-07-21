  class ProductModel {
    late String? id;
    late String? Image;
    late String? Name;
    late String? Description;
    late String? Barcode;
    late String? Store;

    late int? Price;


  ProductModel({
      this.id,
      this.Image,
      this.Name,
      this.Description,
      this.Barcode,
      this.Store,
      this.Price
    });


  ProductModel.fromJson(Map<String, dynamic> json){
    id = json ["_id"];
    Image = json ["image"];
    Name = json ["name"];
    Description = json ["description"];
    Barcode = json ["barcode"];
    Store = json ["store"];
    Price = json ["productPrice"];
    }


  Map<String, dynamic> toJson(){
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["image"] = Image;
    _data["name"] = Name;
    _data["description"] = Description;
    _data["barcode"] = Barcode;
    _data["store"] = Store;
    _data["productPrice"] = Price;

    return _data;
  }




    }