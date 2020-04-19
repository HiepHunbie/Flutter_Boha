class GetDataInput{
  String owner;
  String phone;
  String email;
  String name;
  GetDataInput({this.owner, this.phone,this.email, this.name});

  factory GetDataInput.fromJson(Map<String, dynamic> json) {
    return GetDataInput(
      owner: json['owner'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["owner"] = owner;
    map["phone"] = phone;
    map["email"] = email;
    map["name"] = name;
    return map;
  }
}