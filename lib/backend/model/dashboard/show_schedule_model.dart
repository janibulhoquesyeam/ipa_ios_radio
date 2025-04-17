class ShowScheduleModel {
  final Data data;

  ShowScheduleModel({
    required this.data,
  });

  factory ShowScheduleModel.fromJson(Map<String, dynamic> json) => ShowScheduleModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Day> days;
  final String baseUrl;
  final String imagePath;

  Data({
    required this.days,
    required this.baseUrl,
    required this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
    baseUrl: json["base_url"],
    imagePath: json["image-path"],
  );
}

class Day {
  final int id;
  final int adminId;
  final String name;
  final String slug;
  final int status;
  final List<DailySchedule> dailySchedule;

  Day({
    required this.id,
    required this.adminId,
    required this.name,
    required this.slug,
    required this.status,
    required this.dailySchedule,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    adminId: json["admin_id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    dailySchedule: List<DailySchedule>.from(json["daily_schedule"].map((x) => DailySchedule.fromJson(x))),
  );
}

class DailySchedule {
  final int id;
  final int adminId;
  final int dayId;
  final String name;
  final String slug;
  final String chatLink;
  final String radioLink;
  final String host;
  final String description;
  final int isLive;
  final String image;
  final int status;
  final String startTime;
  final String endTime;

  DailySchedule({
    required this.id,
    required this.adminId,
    required this.dayId,
    required this.name,
    required this.slug,
    required this.chatLink,
    required this.radioLink,
    required this.host,
    required this.description,
    required this.isLive,
    required this.image,
    required this.status,
    required this.startTime,
    required this.endTime,
  });

  factory DailySchedule.fromJson(Map<String, dynamic> json) => DailySchedule(
    id: json["id"],
    adminId: json["admin_id"],
    dayId: json["day_id"],
    name: json["name"],
    slug: json["slug"],
    chatLink: json["chat_link"],
    radioLink: json["radio_link"],
    host: json["host"],
    description: json["description"],
    isLive: json["is_live"],
    image: json["image"],
    status: json["status"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );
}