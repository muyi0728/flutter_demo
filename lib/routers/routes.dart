import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './routerHandler.dart';

class Routes {
  static String root = "/";
  static String commodityDetail = "/commodity-detail";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
    router.define(commodityDetail, handler: commodityDetailHandler);
  }
}