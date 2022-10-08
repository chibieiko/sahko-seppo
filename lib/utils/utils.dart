import 'dart:convert';
import 'package:xml2json/xml2json.dart';

const kQuoteReplacer = "¿*¿*¿*¿*";

/// Taken from https://github.com/sergiofraile/retrofit_xml_sample_app/blob/main/lib/utils/main.dart
class Utils {
  static dynamic decodeXmlResponseToJson(String data) {
    String cleanDataString = data.replaceAll("&quot;", kQuoteReplacer);
    final Xml2Json transformer = Xml2Json();
    transformer.parse(cleanDataString);
    final json = transformer.toGData();
    return jsonDecode(json);
  }
}
