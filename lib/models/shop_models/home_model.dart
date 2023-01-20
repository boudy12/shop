class HomeModel{
  bool? status;
  String? message;
  HomeModelData? data;

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = HomeModelData.fromJson(json['data']);
  }

}

class HomeModelData{
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  HomeModelData.fromJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element){
      banners!.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element){
      products!.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel{

  int? id;
  String? image;
  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel{

  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  List<String>? images = [];
  String? name;
  bool? inFavorites;
  String? description;
  bool? inCart;
  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    description = json['description'];
    inCart = json['in_cart'];
  }
}