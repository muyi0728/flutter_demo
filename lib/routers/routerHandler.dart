import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/commodity_detail_page/index.dart';

Handler commodityDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String commodityId = params['commodityId']?.first;
      String title = params['title']?.first;
      print('index>,articleDetail id is $commodityId');
      return CommodityDetail(commodityId: commodityId, title: title,);
    }
);