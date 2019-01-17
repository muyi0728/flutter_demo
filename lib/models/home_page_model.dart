
/// 首页轮播数据model
class CarouseModel {
  String imageSrc;
  String path;
  CarouseModel.fromJson(Map<String, dynamic> json) {
    imageSrc = json['imageSrc'];
    path = json['path'];
  }
}

/// 首页宫格导航数据model
class GridNavigationModel {
  String imageSrc;
  String name;
//  GridNavigationModel({this.imageSrc, this.name});
  GridNavigationModel.fromJson(Map<String, dynamic> json) {
    imageSrc = json['imageSrc'];
    name = json['name'];
  }
}

/// 商品信息列表数据model
class CommodityInfoModel {
  String imageSrc;
  int newPrice;
  int oldPrice;
  int stock;
  CommodityInfoModel.fromJson(Map<String, dynamic> json) {
    imageSrc = json['imageSrc'];
    newPrice = json['newPrice'];
    oldPrice = json['oldPrice'];
    stock = json['stock'];
  }
}
