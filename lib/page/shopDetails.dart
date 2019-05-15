import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(ShopDetails());

class ShopDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('详情'),
        centerTitle: true,
      ),
      body: new Column(children: <Widget>[
        Expanded(
            child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: 3,
          autoplayDelay: 5000,
          duration:600,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.black54,
            activeColor: Colors.white,
          )),
          control: new SwiperControl(),
          scrollDirection: Axis.horizontal,
          autoplay: true,
        )),
        Divider(
          height: 1.0,
        ),
        Row(children: <Widget>[
          Padding(
            child: Text(
              '￥15.90',
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          Padding(
            child: Text(
              '￥20.90',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ]),
        Align(
          child: Padding(
            child: Text('深度思考：让所有事情都能正确入手'),
            padding: EdgeInsets.all(10.0),
          ),
          alignment: Alignment.centerLeft,
        ),
        Align(
          child: Padding(
            child: Text(
              '凯茜 拉舍， 文通天下 著',
              style: TextStyle(fontSize: 12.0),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          alignment: Alignment.centerLeft,
        ),
        Align(
          child: Padding(
            child: Text(
              '限购 购买1-20件时享受单件价￥15.90',
              style: TextStyle(fontSize: 12.0),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          alignment: Alignment.centerLeft,
        ),
        Divider(),
        Align(
          child: Padding(
            child: Text(
              '快递 免邮',
              style: TextStyle(fontSize: 12.0),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          alignment: Alignment.centerLeft,
        ),
        Divider(),
        Align(
          child: Padding(
            child: Text(
              '温馨提示： 支持7天无理由退货',
              style: TextStyle(fontSize: 12.0),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          alignment: Alignment.centerLeft,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  onPressed: () {},
                  color: Colors.orange,
                  child: Padding(
                    child: Text('使用礼品券购买购买'),
                    padding: EdgeInsets.all(12.0),
                  )),
            ),
            FlatButton(
                onPressed: () {},
                color: Colors.red,
                child: Padding(
                  child: Text('立即购买'),
                  padding: EdgeInsets.all(12.0),
                )),
          ],
        )
      ]),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return(
      Image.asset('images/shop/1.jpg')
    );
  }
}
