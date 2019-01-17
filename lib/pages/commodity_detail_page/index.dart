import 'package:flutter/material.dart';

class CommodityDetail extends StatelessWidget {
  final String commodityId;
  final String title;

  CommodityDetail({@required this.commodityId, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("这个商品的id是$commodityId"),
      ),
    );
  }
}
