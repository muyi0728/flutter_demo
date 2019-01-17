import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
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
