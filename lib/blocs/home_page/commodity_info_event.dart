import '../../bloc_helpers/bloc_event_state.dart';

class CommodityInfoEvent extends BlocEvent {
  final CommodityInfoEventType type;
  CommodityInfoEvent({
    this.type: CommodityInfoEventType.firstLoad,
  }) : assert(type != null);
}

enum CommodityInfoEventType {
  firstLoad,
  loadMore,
}