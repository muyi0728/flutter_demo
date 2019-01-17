
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
  GridNavigationModel.fromJson(Map<String, dynamic> json) {
    imageSrc = json['imageSrc'];
    name = json['name'];
  }
}

/// 首页轮播、宫格导航数据组合model
class HomePageCommonModel {
  List<CarouseModel> carouselList;
  List<GridNavigationModel> gridNavigationList;
  HomePageCommonModel({this.carouselList, this.gridNavigationList});
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

/// 商品信息列表数据请求参数model
class CommodityInfoQueryModel {
  int pageIndex;
  int pageSize;
  CommodityInfoQueryModel({this.pageIndex: 0, this.pageSize: 6});
  Map<String, dynamic> toJson() => {
    'pageIndex': pageIndex,
    'pageSize': pageSize,
  };
}
