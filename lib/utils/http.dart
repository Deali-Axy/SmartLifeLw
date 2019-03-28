import 'dart:io';
import 'dart:convert';

/// http方法 get
/// 这里不做错误处理，由上层调用捕捉错误
Future<String> get(String url) async {
  var httpClient = new HttpClient();

  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  if (response.statusCode == HttpStatus.ok) {
    var rawStr = await response.transform(utf8.decoder).join();
    return rawStr;
  } else {
    return '';
  }
}

/// http方法 post
Future<String> post(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  if (response.statusCode == HttpStatus.ok) {
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  } else
    return '';
}