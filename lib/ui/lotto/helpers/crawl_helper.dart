import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:html/parser.dart' show parse;
import 'package:xml2json/xml2json.dart';

class CrawlHelper 
{
  static Future<dynamic> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> createAlbum(String title) async {
    final http.Response response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  static Future<dynamic> test(String title) async {
    final params = jsonEncode(<String, String>{
      'date': '20211029',
    });
    //print(params);

    final http.Response response = await http.post(
        Uri.parse('http://xosothudo.com.vn/LotteryResult/LastResultHome'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: 'date=20211027',
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      throw Exception('Error ${response.statusCode} : Failed to create album.');
    }
  }

  static String formatParam(String value, String format) {
    if (format.isNotEmpty) {
      if (format.startsWith(RegExp(r'0'), 1)) {
        NumberFormat formatter = NumberFormat(format);
        value = formatter.format(int.parse(value));
      }
      if (DateTime.tryParse(value) != null) {
        DateTime drawtime = DateTime.parse(value);
        value = DateFormat(format).format(drawtime);
      }
    }
    return value;
  }

  static Future<dynamic> getData(String url, String param, String value) async {
    final response = await http.get(Uri.parse('$url?$param=$value'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get data');
    }
  }

  static Future<dynamic> postData(String url,
      {Map<String, String>? data, bool json = false}) async {
    var parts = [];
    data!.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var databody = parts.join('&');

    final http.Response response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "Cache-Control": "no-cache"
        },
        body: databody,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return json ? response.toString() : response.body;
    } else {
      throw Exception('Error ${response.statusCode} : Failed to post data.');
    }
  }

  static Future<dynamic> postJson(String url,
      {Map<String, String>? data, bool json = false}) async {
    var parts = [];
    data!.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var databody = parts.join('&');

    final http.Response response = await http.post(Uri.parse(url),
        headers: {
          "accept": "*/*",
          "accept-language": "vi,en-US;q=0.9,en;q=0.8",
          "content-type": "application/x-www-form-urlencoded",
        },
        body: databody,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return json ? response.toString() : response.body;
    } else {
      throw Exception('Error ${response.statusCode} : Failed to post data.');
    }
  }

  static Future<dynamic> getContent(String url, int method, String param,
      String value, String format, String node) async {
    String content = '';
    value = formatParam(value, format);
    if (method == 0) {
      content = await getData(url, param, value);
    } else if (method == 1) {
      var data = <String, String>{
        param: value,
      };
      content = await postData(url, data: data);
    }

    if (node.isNotEmpty) {
      content = getNode(content, node);
    }
    return content;
  }

  static String getNode(String source, String selector) {
    if (source.isNotEmpty && selector.isNotEmpty) {
      var document = parse(source);
      var nodes = document.querySelectorAll(selector);
      String result = '';
      for (var element in nodes) {
        result += element.outerHtml;
      }
      return result;
    }
    return source;
  }

  static String getTagName(String source, String selector) {
    if (source.isNotEmpty && selector.isNotEmpty) {
      var document = parse(source);
      var nodes = document.querySelectorAll(selector);
      String result = '';
      for (var element in nodes) {
        result += element.text;
      }
      return result;
    }
    return source;
  }

  // Prize
  static String getJson(String xml) {
    if (xml.isNotEmpty) {
      final Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(xml);
      return xml2Json.toParker();
    }
    return '';
  }
}