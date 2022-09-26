class CreateUserModel {
  int code;
  String message;
  String iD;

  CreateUserModel({this.code, this.message, this.iD});

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    message = json['Message'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Message'] = this.message;
    data['ID'] = this.iD;
    return data;
  }
}