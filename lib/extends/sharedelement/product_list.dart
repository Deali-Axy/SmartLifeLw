import 'package:flutter/material.dart';
import 'product_detail.dart';

class ProductItem {
  final String name;
  final String tag;
  final String asset;
  final int stock;
  final double price;

  ProductItem({
    this.name,
    this.tag,
    this.asset,
    this.stock,
    this.price,
  });
}

final List<ProductItem> circlePosts = [
  ProductItem(
      name: '我好想做打代码的工作 但是家人跟我说做公务员更加稳定 我究竟要如何选择？',
      tag: '1',
      asset: '打代码是我高中一直以来的兴趣，却得不到家人的支持 我要怎么办',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: '刚大学毕业 大学四年基本都是混过来的 我现在很迷茫 该怎么办',
      tag: '2',
      asset: '很后悔大学期间没有努力学习 现在不知道该怎么办了',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: '老板交给我的任务我已经努力去做了，但每次还是被老板批评，我该怎么办？',
      tag: '3',
      asset: '我已经尽自己努力去完成了 但还是做不好 我好迷茫',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: '我今天高二 刚转学 跟新的同学完全说不上话 每天一个人',
      tag: '4',
      asset: '完全融入不了新集体 我好迷茫',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: '研究生导师交给我一个任务 说我肯定可以完成 但是我发现我根本完不成',
      tag: '5',
      asset: '5.但也不好意思拒绝 我该怎么办 导师那么相信我 我却完成不了 我该怎么办',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: '我今天大二 身边的同学都加了社团之类的团体 我只是每天按时去上课',
      tag: '6',
      asset: '6.感觉找不到未来的方向 大家都有事情做 我没有什么具体的事做 我该怎么办',
      stock: 1,
      price: 71.0),
];

class ProductListPage extends StatefulWidget {
  final String title;

  const ProductListPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends State<ProductListPage> {
  Widget _buildSearch() {
    return Hero(
        tag: 'search',
        child: Card(
          margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            height: 45.0,
            child: Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black26,
                      size: 20.0,
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search category',
                        hintStyle: TextStyle(color: Colors.black26)),
                    cursorColor: Theme.of(this.context).accentColor,
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildProduct(ProductItem product) {
    var width = MediaQuery.of(context).size.width;
    return Hero(
      tag: product.tag,
      child: Container(
        height: 120.0,
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Positioned(
                left: 20.0,
                child: Card(
                  child: Container(
                    width: width - 15.0 * 2 - 20.0 - 50.0,
                    margin: EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.title,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${product.stock} Unit',
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60.0,
                          width: 1.0,
                          color: Colors.black12,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'PRICE',
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                              MaterialButton(
                                height: 30.0,
                                child: Text('BUY'),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                        pageBuilder: (context, _, __) {
                                          return ProductDetailPage(
                                            product: product,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: FadeTransition(
                                              opacity:
                                                  Tween(begin: 0.5, end: 1.0)
                                                      .animate(animation),
                                              child: child,
                                            ),
                                          );
                                        }),
                                  );
                                },
                                color: Colors.deepPurpleAccent,
                                textColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          _buildSearch(),
          Expanded(
            child: ListView.builder(
                itemCount: circlePosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildProduct(circlePosts[index]);
                }),
          )
        ],
      ),
    );
  }
}
