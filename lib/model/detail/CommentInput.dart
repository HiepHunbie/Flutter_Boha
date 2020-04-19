class CommentInput{
  String user_id;
  String post_id;
  int type;
  String comment;
  CommentInput({this.user_id, this.post_id,this.type, this.comment});

  factory CommentInput.fromJson(Map<String, dynamic> json) {
    return CommentInput(
      user_id: json['user_id'],
      post_id: json['post_id'],
      type: json['type'],
      comment: json['comment'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = user_id;
    map["post_id"] = post_id;
    map["type"] = type;
    map["comment"] = comment;
    return map;
  }
}