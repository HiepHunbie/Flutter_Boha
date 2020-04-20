class GetDataInput{
  String owner;
  String phone;
  String email;
  String name;
  String player_id;
  GetDataInput({this.owner, this.phone,this.email, this.name,this.player_id});

  factory GetDataInput.fromJson(Map<String, dynamic> json) {
    return GetDataInput(
      owner: json['owner'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
      player_id: json['player_id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["owner"] = owner;
    map["phone"] = phone;
    map["email"] = email;
    map["name"] = name;
    map["player_id"] = player_id;
    return map;
  }
}