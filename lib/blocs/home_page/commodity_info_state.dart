import '../../bloc_helpers/bloc_event_state.dart';
import '../../models/home_page_model.dart';

class CommodityInfoState extends BlocState {
  final bool isLoading;
  final List<CommodityInfoModel> commodityInfoList;
  CommodityInfoState({this.isLoading: false, this.commodityInfoList});

  /// 数据初始化
  factory CommodityInfoState.initState() {
    return CommodityInfoState(
        isLoading: false,
    );
  }

  factory CommodityInfoState.startLoad(commodityInfoList) {
    return CommodityInfoState(
      isLoading: true,
      commodityInfoList: commodityInfoList,
    );
  }

  factory CommodityInfoState.finishedLoad(List<CommodityInfoModel> commodityInfoList) {
    return CommodityInfoState(
      isLoading: false,
      commodityInfoList: commodityInfoList,
    );
  }

}

