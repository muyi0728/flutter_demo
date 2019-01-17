import '../../bloc_helpers/bloc_event_state.dart';
import 'commodity_info_event.dart';
import 'commodity_info_state.dart';
import '../../models/home_page_model.dart';
import '../../repository/home_repository.dart';

class CommodityInfoBloc extends BlocEventStateBase<CommodityInfoEvent, CommodityInfoState> {
  CommodityInfoBloc() : super(initialState: CommodityInfoState.initState());

  List<CommodityInfoModel> _tempList = [];

  /// 实例化 repository
  HomeRepository repository = new HomeRepository();

  @override
  Stream<CommodityInfoState> eventHandler(CommodityInfoEvent event, CommodityInfoState currentState) async* {
    List<CommodityInfoModel> list;
    if (!currentState.isLoading) {
      yield CommodityInfoState.startLoad(_tempList);
//      list = await repository.getCommodityInfo();
      _tempList.addAll(list);
    }
    if (event.type == CommodityInfoEventType.firstLoad) {
      yield CommodityInfoState.finishedLoad(list);
    } else if (event.type == CommodityInfoEventType.loadMore) {
      yield CommodityInfoState.finishedLoad(_tempList);
    }
  }
}
