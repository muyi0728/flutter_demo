import 'package:rxdart/rxdart.dart';
import '../../bloc_helpers/bloc_provider.dart';

/// 返回顶部 Stream
class ReturnTopBloc implements BlocBase {
  BehaviorSubject<bool> _returnTopController = BehaviorSubject<bool>();
  Sink<bool> get _returnTopControllerSink => _returnTopController.sink;
  Stream<bool> get returnTopController => _returnTopController.stream;

  void setReturnTopStatus({bool isShowReturnTopBtn: false}){
    _returnTopControllerSink.add(isShowReturnTopBtn);
  }

  @override
  void dispose() {
    _returnTopController.close();
  }
}