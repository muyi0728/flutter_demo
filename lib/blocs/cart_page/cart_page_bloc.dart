import 'package:rxdart/rxdart.dart';
import '../../bloc_helpers/bloc_provider.dart';
import '../../models/cart_page_model.dart';


final List testList = [
  {
    'imageSrc': 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=534198674,4032302864&fm=26&gp=0.jpg',
    'path': 'test'
  },
  {
    'imageSrc': 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=534198674,4032302864&fm=26&gp=0.jpg',
    'path': 'test'
  },
  {
    'imageSrc': 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=534198674,4032302864&fm=26&gp=0.jpg',
    'path': 'test'
  }
];

class CartPageBloc implements BlocBase {
  BehaviorSubject<List<CartPageTestModel>> _testStream =  BehaviorSubject<List<CartPageTestModel>>();
  Sink<List<CartPageTestModel>> get _testStreamSink => _testStream.sink;
  Stream<List<CartPageTestModel>> get testStream => _testStream;


  void getList() {
    List<CartPageTestModel> _list;
    _list = testList.map((item) => CartPageTestModel.fromJson(item)).toList();
    _testStreamSink.add(_list);
  }

  @override
  void dispose() {
    _testStream.close();
  }
}