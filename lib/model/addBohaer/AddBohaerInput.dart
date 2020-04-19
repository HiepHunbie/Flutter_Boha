
class AddBohaerInput{
String user_id;
String phone;
String name;
int type;
String address;
String history;
AddBohaerInput({this.user_id, this.phone,this.name, this.type
,this.address, this.history});

factory AddBohaerInput.fromJson(Map<String, dynamic> json) {
return AddBohaerInput(
user_id: json['user_id'],
phone: json['phone'],
name: json['name'],
type: json['type'],
address: json['address'],
history: json['history'],
);
}

Map toMap() {
var map = new Map<String, dynamic>();
map["user_id"] = user_id;
map["phone"] = phone;
map["name"] = name;
map["type"] = type;
map["address"] = address;
map["history"] = history;
return map;
}
}