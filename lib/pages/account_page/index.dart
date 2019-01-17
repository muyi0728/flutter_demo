import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
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
