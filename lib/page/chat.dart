import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_life_lw/little_white.dart';
import 'package:smart_life_lw/widget/chat_message.dart';
import 'package:image_picker/image_picker.dart';

import '../models.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  final TextEditingController _textController = new TextEditingController();
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  List<Message> _messages = List();
  List<Widget> _chatCards = List();
  bool _isComposing = false;
  ScrollController _scrollController = new ScrollController();

  _PageState() {
    var msg = Message(
        type: 'text', content: '欢迎使用汇智Life', from: Message.HUIZHI, to: '用户');
    _messages.add(msg);
    _chatCards.add(LwMessage(content: msg.content, name: msg.from));
  }

  /// 添加一条信息
  _addMessage(Message msg) {
    _messages.add(msg);
    setState(() {
      _chatCards = _messages
          .expand((msg) => {
                msg.from == Message.HUIZHI
                    ? LwMessage(content: msg.content, name: msg.from)
                    : UserMessage(content: msg.content, name: msg.from)
              })
          .toList();
    });
  }

  /// 处理提交的信息
  _handleSubmitted(String text) async {
    _addMessage(
        Message(type: Message.TEXT, content: text, from: '用户', to: null));
    _textController.clear();
    _isComposing = false;

    // 滚动到底部
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    Message message = await LittleWhite.sendText(text);
    _addMessage(message);
  }

  Widget _msgEditor() {
    return IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.photo_camera),
                  onPressed: () async {
                    File imageFile =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                  }),
            ),
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(hintText: '发送消息'),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天中'),
      ),
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              new Flexible(
                child: ListView(
                  controller: _scrollController,
                  children: _chatCards,
                ),
              ),
              _msgEditor(),
            ],
          ),
        ),
      ),
    );
  }
}
