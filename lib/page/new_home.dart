import 'package:flutter/material.dart';
import 'shop.dart';

class NewHomePage extends StatefulWidget {
  NewHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  //TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('汇智life'),
          leading: Icon(Icons.menu),
          centerTitle: true,
          actions: <Widget>[
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new Myshop()),
                  );
                },
                child: Text(
                  '专注商城',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverFillRemaining(
            child: Card(
              elevation: 10.0,
              margin: EdgeInsets.only(top: 10.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
              ),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                          child: Text(
                            '当前行程',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                          ),
                          padding: EdgeInsets.all(20.0)),
                      Expanded(
                        child: Text(''),
                      )
                    ],
                  ),
                  Padding(
                    child: Align(
                      child: Text('养神',
                          style: TextStyle(fontSize: 30.0, color: Colors.grey)),
                      alignment: Alignment.center,
                    ),
                    padding: EdgeInsets.only(top: 80.0, left: 30, bottom: 30.0),
                  ),
                  Padding(
                    child: Text(
                      '9:00-9:05',
                      style: TextStyle(fontSize: 30.0, color: Colors.grey),
                    ),
                    padding: EdgeInsets.only(bottom: 100.0),
                  ),
                  Padding(
                    child: Text(
                      '你的专注程度比以前进步了  >  ',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    padding: EdgeInsets.only(bottom: 15.0),
                  ),
                  Expanded(
                      child: Container(
                    width: 1800.0,
                    color: Color(0xFFF2DFDF),
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text(
                            '按住7秒后中断行程',
                            style: TextStyle(
                                fontSize: 20.0, color: Color(0xFF706F6F)),
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            tooltip: '点击',
                            onPressed: () {},
                            child: Padding(
                                child: Icon(
                                  Icons.fingerprint,
                                  color: Color(0xFFF5B4BE),
                                  size: 80.0,
                                ),
                                padding: EdgeInsets.only(top: 10.0)))
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                  )),
                ],
              )),
            ),
          ),
          SliverFillRemaining(
            child: Card(
              elevation: 10.0,
              margin: EdgeInsets.only(top: 60.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
              ),
              child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '我的计划',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                          ),
                          Expanded(
                            child: Text(''),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ]));
  }
}

// return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//           leading: new Icon(Icons.menu),
//           bottom: new TabBar(
//             indicatorColor: Color(0xffffffff),
//             tabs: <Widget>[
//               new Tab(
//                 text: '当前行程',
//               ),
//               new Tab(
//                 text: '我的计划',
//               ),
//             ],
//           ),
//         ),
//         body: new TabBarView(
//           controller: _tabController,
//           children: <Widget>[
//             new Center(child: new Text('当前行程')),
//             new Center(child: new Text('我的计划')),
//           ],
//         ),
//       ),
//     );
