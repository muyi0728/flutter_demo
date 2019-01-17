import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('social'),
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
