class LoginWithPhoneModel {
  int userid;
  String name;

  LoginWithPhoneModel({this.userid, this.name});

  LoginWithPhoneModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    return data;
  }
}