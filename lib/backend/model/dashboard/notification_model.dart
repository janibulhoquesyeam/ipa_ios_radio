class NotificationModel {
  final Data data;

  NotificationModel({
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Notification> notifications;

  Data({
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );
}

class Notification {
  final Message message;
  final DateTime createdAt;

  Notification({
    required this.message,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    message: Message.fromJson(json["message"]),
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Message {
  final String title;
  final String message;

  Message({
    required this.title,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    title: json["title"],
    message: json["message"],
  );
}