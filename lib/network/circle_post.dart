import 'dart:convert';
import 'package:smart_life_lw/utils/http.dart';

class CirclePost {
  String id;
  String title;
  String biography;
  String type;
  String nickname;
  String time;

  CirclePost(
      {this.id,
      this.title,
      this.biography,
      this.type,
      this.nickname,
      this.time});
}

class CirclePostComment {
  String id;
  String parentid;
  String biography;
  String nickname;
  String time;

  CirclePostComment(
      {this.id, this.parentid, this.biography, this.nickname, this.time});
}

class CirclePostUtils {
  static getAllPosts() async => await getPosts(1);

  static getPosts(int id) async {
    var url = 'http://47.106.203.63:8080/HZlife/circleList/$id';
    var responseStr = await get(url);
    var postList = List<CirclePost>();
    Map jsonMap = jsonDecode(responseStr);
    for (Map item in jsonMap['data']) {
      postList.add(CirclePost(
          id: item['id'],
          title: item['title'],
          biography: item['biography'],
          type: item['type'],
          nickname: item['nickname'],
          time: item['time']));
    }
    return postList;
  }

  static getComments(String id) async {
    var url = 'http://47.106.203.63:8080/HZlife/circlezpl/$id';
    var responseStr = await get(url);
    var commentList = List<CirclePostComment>();
    Map jsonMap = jsonDecode(responseStr);
    for (Map item in jsonMap['data']) {
      commentList.add(CirclePostComment(
          id: item['id'],
          parentid: item['parentid'].toString(),
          biography: item['biography'],
          nickname: item['nickname'],
          time: item['time']));
    }
    return commentList;
  }
}
