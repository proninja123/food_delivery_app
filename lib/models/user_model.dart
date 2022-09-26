class UserDataModel {
  String userId;
  String userName;
  String fullName;
  String userEmail;
  String userNumber;
  bool isLoggedIn;
  String authToken;

  UserDataModel(
      {this.userId,
      this.userName,
      this.fullName,
      this.userEmail,
      this.isLoggedIn,
      this.userNumber,
      this.authToken});

  String getPhoneNumber() {
    return userNumber;
  }

  String getUserId() {
    return userId;
  }

  bool isLogin() {
    return isLoggedIn;
  }

  String getFullName() {
    return fullName;
  }

  String getUserName() {
    return userName;
  }

  String getEmail() {
    return userEmail;
  }

  String getToken() {
    return authToken;
  }

  setAuthToken(String token) {
    this.authToken = token;
  }

  setLogin(bool isLogin) {
    isLoggedIn = isLogin;
  }

  setPhoneNumber(String number) {
    this.userNumber = number;
  }

  setUserName(String name) {
    this.userName = name;
  }

  setUserId(String id) {
    this.userId = id;
  }

  setFullName(String fullName) {
    this.fullName = fullName;
  }

  setUserEmail(String email) {
    this.userEmail = email;
  }

  Map<String, dynamic> toMap(UserDataModel user) => {
        'id': user.userId,
        'name': user.fullName,
        'username': user.userName,
        'email': user.userEmail,
        'phone': user.userNumber,
        'isLoggedIn': user.isLoggedIn,
        'authToken': user.authToken,
      };

  factory UserDataModel.fromJson(Map<String, dynamic> jsonData) {
    return UserDataModel(
      userId: jsonData['id'],
      fullName: jsonData['name'],
      userName: jsonData['username'],
      userEmail: jsonData['email'],
      userNumber: jsonData['phone'],
      isLoggedIn: jsonData['isLoggedIn'],
      authToken: jsonData['authToken'],
    );
  }
}
