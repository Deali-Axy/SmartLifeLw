import 'package:flutter/material.dart';
import './shopDetails.dart';

void main() => runApp(Myshop());

class Myshop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('专注商城'),
        centerTitle: true,
      ),
      body: new GridView.count(
        childAspectRatio: 0.58,
        primary: false,
        padding: EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20.0,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap:(){
              Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ShopDetails()),
                  );
            } ,
            child: Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Image.asset('./images/shop/1.jpg'),
                  Padding(
                    child: Text(
                      '专注力专注力专注力专注力专注力专注力专注',
                      style: TextStyle(color: Colors.grey),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Text(
                          '￥134.60',
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                      Text(
                        '￥179.40',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset('./images/shop/2.jpg'),
                Padding(
                  child: Text(
                    '专注力专注力专注力专注力专注力专注力专注',
                    style: TextStyle(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        '￥112.60',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      '￥179.40',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset('./images/shop/3.jpg'),
                Padding(
                  child: Text(
                    '专注力专注力专注力专注力专注力专注力专注',
                    style: TextStyle(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        '￥115.60',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      '￥179.40',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset('./images/shop/4.jpg'),
                Padding(
                  child: Text(
                    '专注力专注力专注力专注力专注力专注力专注',
                    style: TextStyle(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        '￥134.60',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      '￥179.40',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset('./images/shop/5.jpg'),
                Padding(
                  child: Text(
                    '专注力专注力专注力专注力专注力专注力专注',
                    style: TextStyle(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        '￥134.60',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      '￥179.40',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset('./images/shop/6.jpg'),
                Padding(
                  child: Text(
                    '专注力专注力专注力专注力专注力专注力专注',
                    style: TextStyle(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        '￥134.60',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      '￥179.40',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
