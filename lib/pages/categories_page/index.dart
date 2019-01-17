import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  child: Text("Bloc测试"),
                ),
              ),
              ClipOval(
                  // child: Image.asset("name"),
                  )
            ],
          ),
        ));
  }
}
