import 'package:flutter/material.dart';
import 'package:smart_life_lw/extends/sharedelement/product_list.dart';

class SliverListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverList'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _buildItem(context, circlePosts[index]);
              },
              childCount: circlePosts.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, ProductItem product) {
    return  Container(
      height: 120.0,
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Positioned(
                left: 30.0,
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(left: 50.0),
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                )),
            ClipRRect(
              child: SizedBox(
                width: 70.0,
                height: 70.0,
                child: Image.asset(
                  product.asset,
                  fit: BoxFit.cover,
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ],
        ),
    );
  }
}
