class LoginModel {
  final Data data;

  LoginModel({
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;
  final UserInfo userInfo;
  final Authorization authorization;

  Data({
    required this.token,
    required this.userInfo,
    required this.authorization,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    authorization: Authorization.fromJson(json["authorization"]),
  );
}

class Authorization {
  final bool status;
  final String token;

  Authorization({
    required this.status,
    required this.token,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
    status: json["status"],
    token: json["token"],
  );
}

class UserInfo {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final int emailVerified;

  UserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.emailVerified,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    emailVerified: json["email_verified"],
  );
}