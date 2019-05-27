import 'package:flutter/material.dart';
import 'package:smart_life_lw/extends/sharedelement/product_list.dart';

final List<ProductItem> _products = [
  ProductItem(
    name: 'Bueno Chocolate',
    summary: 'images/food01.jpeg',
  ),
  ProductItem(
    name: 'Chocolate with berries',
    summary: 'images/food02.jpeg',
  ),
  ProductItem(
    name: 'Trumoo Candies',
    summary: 'images/food03.jpeg',
  ),
  ProductItem(
    name: 'Choco-coko',
    summary: 'images/food04.jpeg',
  ),
  ProductItem(
    name: 'Chocolate tree',
    summary: 'images/food05.jpeg',
  ),
  ProductItem(
    name: 'Chocolate',
    summary: 'images/food06.jpeg',
  ),
  ProductItem(
    name: 'Bueno Chocolate',
    summary: 'images/food01.jpeg',
  ),
  ProductItem(
    name: 'Choco-coko',
    summary: 'images/food04.jpeg',
  ),
  ProductItem(
    name: 'Chocolate tree',
    summary: 'images/food05.jpeg',
  ),
];

class SliverGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverGrid'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildItem(context, _products[index]);
              },
              childCount: _products.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, ProductItem product) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                child: SizedBox(
                  width: 65.0,
                  height: 65.0,
                  child: Image.asset(
                    product.summary,
                    fit: BoxFit.cover,
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text(
                    product.name,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
