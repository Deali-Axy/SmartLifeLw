import 'package:flutter/material.dart';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/extends/sharedelement/product_list.dart';

class ExpandedAppBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpandedAppBarState();
}

class _ExpandedAppBarState extends State<ExpandedAppBarPage> {
  BuildContext _context;
  bool floating = false;
  bool snap = false;
  bool pinned = false;

  @override
  Widget build(BuildContext context) {
    _context=context;
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              _buildAction(),
            ],
            title: Text('迷茫boy的圈子', style: TextStyle(color: Colors.black87)),
            backgroundColor: Theme.of(context).accentColor,
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
//              background: Image.network(
//                  'http://lorempixel.com/320/213/sports?time=${DateTime.now().toString()}',
//                  fit: BoxFit.cover),
              background: Image.asset('images/food06.jpeg', fit: BoxFit.cover),
            ),
            floating: floating,
            snap: snap,
            pinned: pinned,
          ),
          SliverFixedExtentList(
            itemExtent: 130,
            delegate: SliverChildListDelegate(
              circlePosts.map((product) {
                return _buildItem(product);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction() {
    return PopupMenuButton(
      itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('reset'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('floating = true'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('floating = true , snap = true'),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: Text('pinned = true'),
            ),
          ],
      onSelected: (value) {
        switch (value) {
          case 1:
            setState(() {
              floating = false;
              snap = false;
              pinned = false;
            });
            break;
          case 1:
            setState(() {
              floating = true;
              snap = false;
              pinned = false;
            });
            break;
          case 2:
            setState(() {
              floating = true;
              snap = true;
              pinned = false;
            });
            break;
          case 3:
            setState(() {
              floating = false;
              snap = false;
              pinned = true;
            });
            break;
        }
      },
    );
  }

  Widget _buildItem(ProductItem product) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading:
                      Image(image: NetworkImage('http://lorempixel.com/45/45?id=${product.tag}')),
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(product.asset),
                      Text(
                        '${DateTime.now().year}年 ${DateTime.now().month}月 ${DateTime.now().day}日',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  onTap: (){
                    Navigator.pushNamed(_context, UIRoute.circle_content);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
