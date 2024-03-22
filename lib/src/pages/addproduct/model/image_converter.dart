// import 'dart:convert';
// import 'dart:typed_data';

// /// This converter converts to base64 which is supported in json
// class Uint8ListToStringConverter implements JsonConverter<Uint8List?, String> {
//   const Uint8ListToStringConverter();

//   @override
//   Uint8List? fromJson(String json) {
//     if (json == "") return null;
//     return Uint8List.fromList(base64Decode(json));
//   }

//   @override
//   String toJson(Uint8List? object) {
//     if (object == null) return "";
//     return base64Encode(object);
//   }
// }