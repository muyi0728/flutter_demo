import 'package:rxdart/rxdart.dart';
import '../../bloc_helpers/bloc_provider.dart';
import '../../models/home_page_model.dart';
import '../../repository/home_repository.dart';


class HomePageBloc implements BlocBase {

  /// 首页轮播、宫格导航数据 公共Stream
  BehaviorSubject<HomePageCommonModel> _homePageCommonMap = BehaviorSubject<HomePageCommonModel>();
  Sink<HomePageCommonModel> get _homePageCommonMapSink => _homePageCommonMap.sink;
  Stream<HomePageCommonModel> get homePageCommonMap => _homePageCommonMap.stream;

  /// 首页商品信息列表数据 Stream
  BehaviorSubject<List<CommodityInfoModel>> _commodityInfoList = BehaviorSubject<List<CommodityInfoModel>>();
  Sink<List<CommodityInfoModel>> get _commodityInfoListSink => _commodityInfoList.sink;
  Stream<List<CommodityInfoModel>> get commodityInfoList => _commodityInfoList.stream;

  /// 实例化 repository
  HomeRepository repository = new HomeRepository();

  /// 获取轮播、宫格导航数据
  void getCommonList() async {
    List response = await Future.wait([repository.getCarouse(), repository.getGridNavigation()]);
    HomePageCommonModel _list = HomePageCommonModel(carouselList: response[0], gridNavigationList: response[1]);
    _homePageCommonMapSink.add(_list);
  }

  /// 获取商品信息列表数据
  bool _isLoading = false;
  List<CommodityInfoModel> _list = [];

  void getCommodityInfo({int pageIndex = 0}) async {
    CommodityInfoQueryModel _query = new CommodityInfoQueryModel(pageIndex: pageIndex);
    if (_isLoading) return;
    _isLoading = true;
    List<CommodityInfoModel> list = await repository.getCommodityInfo(_query.toJson());
    _isLoading = false;
    _list.addAll(list);
    _commodityInfoListSink.add(_list);
  }

  @override
  void dispose() {
    _commodityInfoList.close();
    _homePageCommonMap.close();
  }
}
