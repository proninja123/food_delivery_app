class LoginModel {
  String code;
  int userID;

  LoginModel({this.code, this.userID});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['userID'] = this.userID;
    return data;
  }
}