import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

/// 定义 BlocEvent 和 BlocState 两个抽象类
/// 这两个抽象类都是要根据在实际业务场景中想要触发的事件和抛出的状态来具体扩展实现
abstract class BlocEvent extends Object {}
abstract class BlocState extends Object {}

/// BlocEventState 抽象类
/// 接收事件 (event) 作为输入
/// 当新的事件触发(输入)时，调用一个对应的事件处理器 eventHandler
/// 事件处理器 (eventHandler) 负责根据事件 (event) 采用适当的处理 (actions) 后，抛出一个或多个状态 (State) 作为响应

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  /// PublishSubject是一个普通广播流（StreamController），可以多次收听
  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();

  /// BehaviorSubject是一个缓存广播流，它能缓存最新一次的事件，并在新的收听者收听的时候将缓存下的事件作为第一帧发送给收听者
  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  /// 定义事件添加入口
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  /// 定义数据状态输出出口
  Stream<BlocState> get state => _stateController.stream;

  /// 定义事件处理器
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  /// 数据状态初始化
  final BlocState initialState;

  BlocEventStateBase({
    @required this.initialState,
  }){
    /// 监听事件流对每个收到的事件，调用[eventHandler]并发出最新的结果
    _eventController.listen((BlocEvent event){
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach((BlocState newState){
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}