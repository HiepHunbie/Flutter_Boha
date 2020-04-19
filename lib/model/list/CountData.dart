import 'dart:convert';

class CountData {
  int totalBoomCount;
  int cheatCount;

  CountData({
    this.totalBoomCount,
    this.cheatCount,
  });

  factory CountData.fromRawJson(String str) => CountData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountData.fromJson(Map<String, dynamic> json) => CountData(
    totalBoomCount: json["totalBoomCount"],
    cheatCount: json["cheatCount"],
  );

  Map<String, dynamic> toJson() => {
    "totalBoomCount": totalBoomCount,
    "cheatCount": cheatCount,
  };
}

