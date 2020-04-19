import 'dart:async';

import 'dart:convert';

import 'package:boha/model/detail/DislikeResult.dart';

import 'CountData.dart';
import 'UserResult.dart';

class Hotel {
  int id;
  String phone;
  String name;
  String address;
  String history;
  dynamic bohaDate;
  int type;
  String userId;
  int totalDislike;
  int totalComment;
  DateTime createdAt;
  DateTime updatedAt;

  Hotel({
    this.id,
    this.phone,
    this.name,
    this.address,
    this.history,
    this.bohaDate,
    this.type,
    this.userId,
    this.totalDislike,
    this.totalComment,
    this.createdAt,
    this.updatedAt,
  });

  factory Hotel.fromRawJson(String str) => Hotel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json["id"],
    phone: json["phone"],
    name: json["name"],
    address: json["address"],
    history: json["history"],
    bohaDate: json["boha_date"],
    type: json["type"],
    userId: json["user_id"],
    totalDislike: json["total_dislike"],
    totalComment: json["total_comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone": phone,
    "name": name,
    "address": address,
    "history": history,
    "boha_date": bohaDate,
    "type": type,
    "user_id": userId,
    "total_dislike": totalDislike,
    "total_comment": totalComment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}


abstract class HotelRepository {
  Future<List<Hotel>> fetchHotels(String phone,int page, int litmit, int type);
  Future<List<UserResult>> registerUser({Map body});
  Future<DislikeResult> dislikePost({Map body});
  Future<CountData> getCount();
}

class DataHotels {

  List<dynamic> data;
  String message;
  int status;

  DataHotels({this.data, this.message, this.status});

  DataHotels.fromMap(Map<String, dynamic> map)
      : data = map['data'],
        message = map['message'],
        status = map['status'];
}

