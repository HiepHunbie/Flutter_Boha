import 'dart:convert';

class ErrorData {
  String field;
  String message;

  ErrorData({
    this.field,
    this.message,
  });

  factory ErrorData.fromRawJson(String str) => ErrorData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
    field: json["field"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "message": message,
  };
}

