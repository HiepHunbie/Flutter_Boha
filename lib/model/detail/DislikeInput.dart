class DislikeInput{
  String user_id;
  String post_id;
  int type;
  int total_dislike;
  DislikeInput({this.user_id, this.post_id,this.type, this.total_dislike});

  factory DislikeInput.fromJson(Map<String, dynamic> json) {
    return DislikeInput(
      user_id: json['user_id'],
      post_id: json['post_id'],
      type: json['type'],
      total_dislike: json['total_dislike'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = user_id;
    map["post_id"] = post_id;
    map["type"] = type;
    map["total_dislike"] = total_dislike;
    return map;
  }
}