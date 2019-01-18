import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../blocs/cart_page/cart_page_bloc.dart';
import '../../models/cart_page_model.dart';

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartPageBloc bloc;

  @override
  void initState() {
    print('开始初始化了....');
    super.initState();
    bloc = CartPageBloc();
    bloc.getList();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Container(
          child: StreamBuilder(
            stream: bloc.testStream,
            builder: (BuildContext context, AsyncSnapshot<List<CartPageTestModel>> snapshot) {
              if (snapshot.data != null) {
                return Container(
                  height: 240,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        snapshot.data[index].imageSrc,
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: snapshot.data.length,
                    autoplay: true,
                    pagination: new SwiperPagination(),
                    onTap: (int index) {
                      // print("$index");
                    },
                  ),
                );
              } else {
                return Text("数据加载中......");
              }
            },
          ),
        ));
  }
}
