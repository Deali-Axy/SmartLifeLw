import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑资料'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network('http://lorempixel.com/100/100/'),
          TextField(
            decoration: InputDecoration(hintText: '用户名'),
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(hintText: '签名'),
          ),
          Row(
            children: <Widget>[
              Text('选择性别：'),
              Radio(value: null, groupValue: null, onChanged: null),
              Text('帅哥'),
              Radio(value: null, groupValue: null, onChanged: null),
              Text('美女'),
            ],
          ),
        ],
      ),
    );
  }
}
