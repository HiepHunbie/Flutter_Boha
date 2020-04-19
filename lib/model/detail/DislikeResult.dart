import 'dart:convert';

class DislikeResult {
  String message;

  DislikeResult({
    this.message,
  });

  factory DislikeResult.fromRawJson(String str) => DislikeResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DislikeResult.fromJson(Map<String, dynamic> json) => DislikeResult(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}