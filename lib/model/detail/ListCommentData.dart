import 'dart:convert';

import 'DislikeResult.dart';

class ListCommentData {
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
  List<Comment> comments;

  ListCommentData({
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
    this.comments,
  });

  factory ListCommentData.fromRawJson(String str) => ListCommentData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListCommentData.fromJson(Map<String, dynamic> json) => ListCommentData(
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
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  int id;
  String userId;
  int type;
  int postId;
  String message;
  int totalDislike;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    this.id,
    this.userId,
    this.type,
    this.postId,
    this.message,
    this.totalDislike,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    postId: json["post_id"],
    message: json["message"],
    totalDislike: json["total_dislike"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "post_id": postId,
    "message": message,
    "total_dislike": totalDislike,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

abstract class DetailRepository {
  Future<ListCommentData> getComments(String posId);
  Future<DislikeResult> putComments({Map body});
  Future<DislikeResult> dislikePost({Map body});
}
