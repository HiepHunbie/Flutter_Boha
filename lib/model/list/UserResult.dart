import 'dart:convert';

class UserResult {
  int id;
  dynamic name;
  String shortId;
  String device;
  String deviceId;
  DateTime createdAt;
  DateTime updatedAt;

  UserResult({
    this.id,
    this.name,
    this.shortId,
    this.device,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserResult.fromRawJson(String str) => UserResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResult.fromJson(Map<String, dynamic> json) => UserResult(
    id: json["id"],
    name: json["name"],
    shortId: json["short_id"],
    device: json["device"],
    deviceId: json["device_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_id": shortId,
    "device": device,
    "device_id": deviceId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

