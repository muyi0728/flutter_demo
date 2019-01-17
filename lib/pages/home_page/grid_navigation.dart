import 'package:flutter/material.dart';
import '../../models/home_page_model.dart';

class GridNavigation extends StatelessWidget {
  final GridNavigationModel gridNavigation;
  GridNavigation(this.gridNavigation);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 68,
            height: 68,
            margin: const EdgeInsets.only(bottom: 6.0),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(const Radius.circular(34)),
                image: DecorationImage(
                    image: NetworkImage(gridNavigation.imageSrc),
                    fit: BoxFit.cover)),
          ),
          Text(gridNavigation.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
