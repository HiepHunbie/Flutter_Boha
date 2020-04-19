class UserInput{
  String device;
  String device_id;

  UserInput({this.device, this.device_id});

  factory UserInput.fromJson(Map<String, dynamic> json) {
    return UserInput(
      device: json['device'],
      device_id: json['device_id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["device"] = device;
    map["device_id"] = device_id;
    return map;
  }
}