import 'package:flutter/material.dart';
import '../bloc_helpers/bloc_event_state.dart';

typedef Widget AsyncBlocStateBuilder<BlocState>(BuildContext context, BlocState state);

/// 当有新的 BlocState 抛出后，将其作为新的参数值调用 builder 方法
/// 根据最新的 BlocState 作出视图层面的响应
class BlocEventStateBuilder<BlocState> extends StatelessWidget {
  const BlocEventStateBuilder({
    Key key,
    @required this.builder,
    @required this.bloc,
  }) : assert(builder != null),
        assert(bloc != null),
        super(key: key);

  final BlocEventStateBase<BlocEvent, BlocState> bloc;
  final AsyncBlocStateBuilder<BlocState> builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
        return builder(context, snapshot.data);
      },
    );
  }
}
