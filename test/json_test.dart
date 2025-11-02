import "package:flutter_test/flutter_test.dart";
import "package:flutter_utilities/src/json.dart";

void main() {
  setUp(() {});
  test("decode simple json map", () {
    String jsonString =
        """{"string": "abc", "int": 0, "double": 0.0, "map": {"substring": "abc"} }""";

    Map<String, Object> map = JsonUtils.decodeStringToMap(jsonString);
    expect(map["string"], equals("abc"));
    expect(map["int"], equals(0));
    expect(map["double"], equals(0.0));

    expect(map["map"], isA<Map>());

    jsonString = """{"string": "abc", "string2": "def", "string3": "ghi" }""";

    Map<String, String> stringMap = JsonUtils.decodeStringToMap(jsonString);
    expect(stringMap["string"], equals("abc"));
    expect(stringMap["string2"], equals("def"));
    expect(stringMap["string3"], equals("ghi"));
  });

  test("decode simple json array", () {
    String jsonString = """["abc", "def", "ghi"]""";

    List<String> list = JsonUtils.decodeStringToList(jsonString);

    expect(list.length, equals(3));
    expect(list[0], equals("abc"));
    expect(list[1], equals("def"));
    expect(list[2], equals("ghi"));

    jsonString = """["abc", 0, 0.0]""";
    List<Object> objectList = JsonUtils.decodeStringToList(jsonString);
    expect(objectList.length, equals(3));
    expect(objectList[0], equals("abc"));
    expect(objectList[1], equals(0));
    expect(objectList[2], equals(0.0));
  });

  test("decode list of json maps", () {
    String jsonString = """[
    {"string": "abc", "int": 0, "double": 0.0, "map": {"substring": "abc"} },
    {"string": "def", "int": 0, "double": 0.0, "map": {"substring": "abc"} }
    ]""";

    List<Map<String, Object>> list =
        JsonUtils.decodeStringToListOfMaps(jsonString);

    expect(list.length, equals(2));
    expect(list[0]["string"], equals("abc"));
    expect(list[1]["string"], equals("def"));

    jsonString = """[
    {"string": "abc", "int": 0, "double": 0.0, "array": [{"substring": "abc"}] },
    {"string": "def", "int": 0, "double": 0.0, "map": {"substring": "abc"} }
    ]""";
    list = JsonUtils.decodeStringToListOfMaps(jsonString);

    expect(list.length, equals(2));
    expect(list[0]["array"], isA<List>());
    expect(list[1]["map"], isA<Map>());
  });
}
