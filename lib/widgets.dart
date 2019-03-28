import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  IconData _icon;
  String _text;

  TextIconButton({@required IconData icon, @required String text}) {
    _icon = icon;
    _text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 60,
        width: Theme.of(context).textTheme.display1.fontSize * 1.1 + 90,
      ),
      alignment: Alignment.center,
//      color: Colors.teal.shade700,
      child: Column(
        children: <Widget>[
          Icon(
            _icon,
            size: 50,
            color: Colors.blue,
          ),
          Text(
            _text,
            style: TextStyle(fontSize: 30, color: Colors.blue),
          )
        ],
      ),
    );
  }
}

class SimpleDivider extends StatelessWidget {
  double _height = 0;
  double _width = 0;

  SimpleDivider({@required double height, double width}) {
    _height = height;
    _width = width;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
