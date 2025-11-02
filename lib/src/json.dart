library;

import "dart:convert";

class JsonUtils {
  static Map<String, V> decodeStringToMap<V>(final String jsonString,
      {Object? Function(Object?, Object?)? reviver}) {
    final raw = json.decode(jsonString, reviver: reviver);
    return Map.castFrom(raw);
  }

  static List<V> decodeStringToList<V>(final String jsonString,
          {Object? Function(Object?, Object?)? reviver}) =>
      List.castFrom(json.decode(jsonString, reviver: reviver));

  static List<Map<String, V>> decodeStringToListOfMaps<V>(
      final String jsonString,
      {Object? Function(Object?, Object?)? reviver}) {
    final raw = json.decode(jsonString, reviver: reviver) as List;
    return raw.map((e) => (e as Map).cast<String, V>()).toList();
  }
}
