import 'package:flutter/material.dart';
import 'package:smart_life_lw/models.dart';
import 'package:smart_life_lw/utils/image_zoomable.dart';

class LwMessage extends StatelessWidget {
  final String name;
  final String content;

  LwMessage({@required this.content, @required this.name});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(name.substring(0, 1))),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(name, style: Theme.of(context).textTheme.subtitle),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                width: MediaQuery.of(context).size.width * 0.7,
                child: new Text(content, softWrap: true),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final String name;
  final String content;

  UserMessage({@required this.content, @required this.name});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Text(name, style: Theme.of(context).textTheme.subtitle),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(content, softWrap: true),
              )
            ],
          ),
          new Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: new CircleAvatar(child: new Text(name.substring(0, 1))),
          ),
        ],
      ),
    );
  }
}
