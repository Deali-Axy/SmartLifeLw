import 'package:flutter/material.dart';
import 'package:smart_life_lw/network/hitokoto.dart';

class HitokotoCard extends StatefulWidget {
  @override
  _HitokotoCardState createState() => _HitokotoCardState();
}

class _HitokotoCardState extends State<HitokotoCard> {
  Hitokoto _hitokoto;

  _HitokotoCardState() {
    _refresh();
  }

  _refresh() async {
    _hitokoto = await HitokotoUtils.getHitokoto();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(_hitokoto == null ? '等待刷新' : _hitokoto.hitokoto),
          subtitle:
              Text('From ${_hitokoto == null ? '等待刷新' : _hitokoto.from_where}'),
          trailing: IconButton(
              icon: Icon(Icons.refresh), onPressed: () => _refresh()),
        ),
      ),
    );
  }
}
