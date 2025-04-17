import 'dashboard_model.dart';

class LiveShowModel {
  final Data data;

  LiveShowModel({
    required this.data,
  });

  factory LiveShowModel.fromJson(Map<String, dynamic> json) => LiveShowModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<NextShowClass> schedule;
  final String baseUrl;
  final String imagePath;

  Data({
    required this.schedule,
    required this.baseUrl,
    required this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    schedule: List<NextShowClass>.from(json["schedule"].map((x) => NextShowClass.fromJson(x))),
    baseUrl: json["base_url"],
    imagePath: json["image-path"],
  );
}
//
// class Schedule {
//   final int id;
//   final int adminId;
//   final int dayId;
//   final String name;
//   final String slug;
//   final String chatLink;
//   final String radioLink;
//   final String host;
//   final String description;
//   final int isLive;
//   final String image;
//   final int status;
//   final String startTime;
//   final String endTime;
//   final Day day;
//
//   Schedule({
//     required this.id,
//     required this.adminId,
//     required this.dayId,
//     required this.name,
//     required this.slug,
//     required this.chatLink,
//     required this.radioLink,
//     required this.host,
//     required this.description,
//     required this.isLive,
//     required this.image,
//     required this.status,
//     required this.startTime,
//     required this.endTime,
//     required this.day,
//   });
//
//   factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
//     id: json["id"],
//     adminId: json["admin_id"],
//     dayId: json["day_id"],
//     name: json["name"],
//     slug: json["slug"],
//     chatLink: json["chat_link"],
//     radioLink: json["radio_link"],
//     host: json["host"],
//     description: json["description"],
//     isLive: json["is_live"],
//     image: json["image"],
//     status: json["status"],
//     startTime: json["start_time"],
//     endTime: json["end_time"],
//     day: Day.fromJson(json["day"]),
//   );
// }
//
// class Day {
//   final int id;
//   final int adminId;
//   final String name;
//   final String slug;
//
//   Day({
//     required this.id,
//     required this.adminId,
//     required this.name,
//     required this.slug,
//   });
//
//   factory Day.fromJson(Map<String, dynamic> json) => Day(
//     id: json["id"],
//     adminId: json["admin_id"],
//     name: json["name"],
//     slug: json["slug"],
//   );
// }