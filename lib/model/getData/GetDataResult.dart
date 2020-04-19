import 'dart:convert';

class GetDataResult {
  String message;

  GetDataResult({
    this.message,
  });

  factory GetDataResult.fromRawJson(String str) => GetDataResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDataResult.fromJson(Map<String, dynamic> json) => GetDataResult(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

abstract class GetDataRepository {
  Future<GetDataResult> getDataInfo({Map body});
}