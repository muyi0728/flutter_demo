import 'package:flutter/material.dart';
import '../models/home_page_model.dart';
import '../routers/application.dart';

class CommodityInfoCard extends StatelessWidget {
  final CommodityInfoModel commodityInfo;

  CommodityInfoCard(this.commodityInfo);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ApplicationRouter.router.navigateTo(context, '/commodity-detail?commodityId=54654&title=${Uri.encodeComponent('测试路由携带参数跳转')}');
      },
      child: Card(
        elevation: 0.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white, width: 1),
                    borderRadius:
                    const BorderRadius.all(const Radius.circular(8))),
                child: Image.network(commodityInfo.imageSrc, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  '￥${commodityInfo.newPrice}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Expanded(
                  child: Text('${commodityInfo.stock}% off',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepOrange,
                      ),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text("￥${commodityInfo.oldPrice}",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.solid)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
