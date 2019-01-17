import 'package:rxdart/rxdart.dart';
import '../../bloc_helpers/bloc_provider.dart';
import '../../models/home_page_model.dart';
import '../../repository/home_repository.dart';

class HomePageBloc implements BlocBase {
  /// 首页轮播图数据 Stream
  BehaviorSubject<List<CarouseModel>> _carouseList = BehaviorSubject<List<CarouseModel>>();
  Sink<List<CarouseModel>> get _carouseListSink => _carouseList.sink;
  Stream<List<CarouseModel>> get carouse => _carouseList.stream;

  /// 首页宫格导航数据 Stream
  BehaviorSubject<List<GridNavigationModel>> _gridNavigationList = BehaviorSubject<List<GridNavigationModel>>();
  Sink<List<GridNavigationModel>> get _gridNavigationListSink => _gridNavigationList.sink;
  Stream<List<GridNavigationModel>> get gridNavigationList => _gridNavigationList.stream;

  /// 实例化 repository
  HomeRepository repository = new HomeRepository();

  /// 首页轮播图数据
  Future getCarouselList() {
    return repository.getCarouse().then((data){
      List<CarouseModel> list = new List();
      list.addAll(data);
      _carouseListSink.add(list);
    });
  }

  /// 首页宫格导航数据
  Future getGridNavigationList() {
    return repository.getGridNavigation().then((data){
      List<GridNavigationModel> list = new List();
      list.addAll(data);
      _gridNavigationListSink.add(list);
    });
  }


  @override
  void dispose() {
    _gridNavigationList.close();
    _carouseList.close();
  }
}