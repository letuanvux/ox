import 'crawl_helper.dart';

class XslHelper
{
  // Transform html to xml by xsl
  static Future<String> getTransformationXSL(String source, String xsl,
      {bool json = false}) async {
    String url = 'http://xsltransform.net/';
    var xml = '<?xml version="1.0" encoding="UTF-8"?>' + source;
    var data = <String, String>{
      'engine': 'Saxon9',
      'revision_id': '0',
      'xml': xml,
      'xsl': xsl,
    };
    try {
      var response = await  CrawlHelper.postData(url, data: data);
      return response;
    } catch (e) {
      //print(url + ': ' + e.toString());
      return '';
    }
  }

  static Future<String> getTransformationXSL2(String source, String xsl,
      {bool json = false}) async {
    String url = 'https://www.online-toolz.com/functions/XSLT.php';
    var xml = '<?xml version="1.0" encoding="UTF-8"?>' + source;
    var data = <String, String>{
      'input': xml,
      'input2': xsl,
    };

    try {
      var response = await CrawlHelper.postJson(url, data: data);
      return response;
    } catch (e) {
      return '';
    }
  }

  static Future<String> xslTransform(String source, String xsl) async {
    RegExp expImg =
        RegExp(r"<img([\w\W]+?)>", multiLine: true, caseSensitive: true);
    RegExp expInput =
        RegExp(r"<input([\w\W]+?)>", multiLine: true, caseSensitive: true);
    source = source.replaceAll(expImg, '');
    source = source.replaceAll(expInput, '');

    var xml = await getTransformationXSL(source, xsl);
    if (xml.isEmpty) {
      xml = await getTransformationXSL2(source, xsl);
    }
    return xml;
  }
}