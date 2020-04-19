import 'dart:convert';

class AddBohaerResult {
  String message;

  AddBohaerResult({
    this.message,
  });

  factory AddBohaerResult.fromRawJson(String str) => AddBohaerResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddBohaerResult.fromJson(Map<String, dynamic> json) => AddBohaerResult(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

abstract class AddBohaerRepository {
  Future<AddBohaerResult> createBohaer({Map body});
}