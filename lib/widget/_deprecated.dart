import 'package:flutter/material.dart';

class Slivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: () {})
            ],
            title: Text('GlobalConfig.selectedCircleName的圈子',
                style: TextStyle(color: Colors.black87)),
            backgroundColor: Theme.of(context).accentColor,
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
//              background: Image.network(
//                  'http://lorempixel.com/320/213/sports?time=${DateTime.now().toString()}',
//                  fit: BoxFit.cover),
              background: Image.asset('images/food06.jpeg', fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [],
            ),
          ),
        ],
      ),
    );
  }
}
