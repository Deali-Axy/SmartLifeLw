import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var selectedProvince = '广东';
  var selectedCity = '广州';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑资料'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: <Widget>[
            Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.network(
                    'http://lorempixel.com/100/100/',
                    fit: BoxFit.fitHeight,
                    height: 100,
                  ),
                  IconButton(
                      icon: Icon(Icons.photo_camera, size: 28),
                      onPressed: () async {
                        File imageFile = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                      })
                ],
              ),
            ),
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
            Row(
              children: <Widget>[
                Text('所在地：'),
                DropdownButton(
                  hint: Text('选择省份'),
                  value: selectedProvince,
                  items: _refreshProvinceList(),
                  onChanged: (T) {
                    setState(() {
                      selectedProvince = T;
                    });
                  },
                ),
                DropdownButton(
                  hint: Text('选择城市'),
                  value: selectedCity,
                  items: _refreshCityList(),
                  onChanged: (T) {
                    setState(() {
                      selectedCity = T;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> _refreshProvinceList() {
    return <DropdownMenuItem>[
      DropdownMenuItem(value: '广东', child: new Text('广东')),
      DropdownMenuItem(value: '福建', child: new Text('福建')),
      DropdownMenuItem(value: '广西', child: new Text('广西')),
      DropdownMenuItem(value: '云南', child: new Text('云南')),
      DropdownMenuItem(value: '湖南', child: new Text('湖南')),
      DropdownMenuItem(value: '浙江', child: new Text('浙江')),
    ];
  }

  List<DropdownMenuItem> _refreshCityList() {
    return <DropdownMenuItem>[
      DropdownMenuItem(value: '广州', child: new Text('广州')),
      DropdownMenuItem(value: '深圳', child: new Text('深圳')),
      DropdownMenuItem(value: '珠海', child: new Text('珠海')),
      DropdownMenuItem(value: '东莞', child: new Text('东莞')),
      DropdownMenuItem(value: '汕头', child: new Text('汕头')),
      DropdownMenuItem(value: '中山', child: new Text('中山')),
    ];
  }
}
