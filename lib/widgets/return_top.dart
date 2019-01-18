import 'package:flutter/material.dart';

class ReturnTop extends StatelessWidget {
  final bool status;
  final Function onPressed;
  ReturnTop({@required this.status, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: status ? 0.0 : 1.0,
      duration: new Duration(milliseconds: 300),
      curve: status ? Curves.easeOut : Curves.easeIn,
      child: new FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        mini: true,
        onPressed: onPressed,
      ),
    );
  }
}
