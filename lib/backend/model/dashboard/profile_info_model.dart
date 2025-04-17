class ProfileInfoModel {
  final Data data;

  ProfileInfoModel({
    required this.data,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) => ProfileInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final UserInfo userInfo;

  Data({
    required this.userInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: UserInfo.fromJson(json["user_info"]),
  );
}

class UserInfo {
  final String firstname;
  final String lastname;
  final String email;
  final Address address;
  final String userImage;
  final String fullName;

  UserInfo({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.userImage,
    required this.fullName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    address: Address.fromJson(json["address"] ?? {}),
    userImage: json["userImage"],
    fullName: json["fullname"],
  );
}

class Address {
  final String country;
  final String state;
  final String city;
  final String zip;

  Address({
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"] ?? "",
    state: json["state"] ?? "",
    city: json["city"] ?? "",
    zip: json["zip"] ?? "",
  );
}