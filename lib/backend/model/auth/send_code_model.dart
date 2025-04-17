class SendCodeModel {
  final Message message;
  final Data data;

  SendCodeModel({
    required this.message,
    required this.data,
  });

  factory SendCodeModel.fromJson(Map<String, dynamic> json) => SendCodeModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;
  final String waitTime;

  Data({
    required this.token,
    required this.waitTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    waitTime: json["wait_time"],
  );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );
}