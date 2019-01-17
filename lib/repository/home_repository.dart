import '../http_sever/http_sever.dart';
import '../models/home_page_model.dart';

class HomeRepository {
  /// 首页轮播图
  Future<List<CarouseModel>> getCarouse() async {
    ResponseModel<List> baseResp = await HttpSeverFactory.getHttp().request<List>(Method.get,'/user/get-carouse');
    List<CarouseModel> list;
    if (baseResp.status) {
      list = baseResp.data.map((item) {
        return CarouseModel.fromJson(item);
      }).toList();
      return list;
    } else {
      return new Future.error(baseResp.msg);
    }
  }

  /// 首页宫格导航
  Future<List<GridNavigationModel>> getGridNavigation() async {
    ResponseModel<List> baseResp = await HttpSeverFactory.getHttp().request<List>(Method.get, '/user/get-grid-nav');
    List<GridNavigationModel> list;
    if (baseResp.status) {
      list = baseResp.data.map((item) {
        return GridNavigationModel.fromJson(item);
      }).toList();
      return list;
    } else {
      return new Future.error(baseResp.msg);
    }
  }

  /// 首页商品列表
  Future<List<CommodityInfoModel>> getCommodityInfo() async {
    ResponseModel<List> baseResp = await HttpSeverFactory.getHttp().request<List>(Method.get, '/user/get-commodity-info');
    List<CommodityInfoModel> list;
    if (baseResp.status) {
      list = baseResp.data.map((item) {
        return CommodityInfoModel.fromJson(item);
      }).toList();
      return list;
    } else {
      return new Future.error(baseResp.msg);
    }
  }
}
