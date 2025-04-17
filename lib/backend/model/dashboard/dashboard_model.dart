class NewsfeedModel {
  final Data data;

  NewsfeedModel({
    required this.data,
  });

  factory NewsfeedModel.fromJson(Map<String, dynamic> json) => NewsfeedModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final NextShow nextShow;
  final Banners banners;
  final Videos videos;

  Data({
    required this.nextShow,
    required this.banners,
    required this.videos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nextShow: NextShow.fromJson(json["next_show"]),
    banners: Banners.fromJson(json["banners"]),
    videos: Videos.fromJson(json["videos"]),
  );
}

class Banners {
  final String baseUrl;
  final String imagePath;
  final List<Banner> banners;

  Banners({
    required this.baseUrl,
    required this.imagePath,
    required this.banners,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
  );
}

class Banner {
  final String title;
  final String description;
  final String image;
  final String buttonName;
  final String buttonLink;

  Banner({
    required this.title,
    required this.description,
    required this.image,
    required this.buttonName,
    required this.buttonLink,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    title: json["title"],
    description: json["description"],
    image: json["image"],
    buttonName: json["button_name"],
    buttonLink: json["button_link"],
  );
}

class NextShow {
  final String baseUrl;
  final String imagePath;
  final NextShowClass nextShow;

  NextShow({
    required this.baseUrl,
    required this.imagePath,
    required this.nextShow,
  });

  factory NextShow.fromJson(Map<String, dynamic> json) => NextShow(
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
    nextShow: NextShowClass.fromJson(json["nextShow"]),
  );
}

class NextShowClass {
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
  final Day day;

  NextShowClass({
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
    required this.day,
  });

  factory NextShowClass.fromJson(Map<String, dynamic> json) => NextShowClass(
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
    day: Day.fromJson(json["day"]),
  );
}

class Day {
  final int id;
  final int adminId;
  final String name;
  final String slug;

  Day({
    required this.id,
    required this.adminId,
    required this.name,
    required this.slug,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    adminId: json["admin_id"],
    name: json["name"],
    slug: json["slug"],
  );
}

class Videos {
  final String baseUrl;
  final String imagePath;
  final List<Video> videos;

  Videos({
    required this.baseUrl,
    required this.imagePath,
    required this.videos,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );
}

class Video {
  final String itemTitle;
  final String image;
  final String itemDescription;
  final String itemLink;
  final DateTime createdAt;

  Video({
    required this.itemTitle,
    required this.image,
    required this.itemDescription,
    required this.itemLink,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    itemTitle: json["item_title"],
    image: json["image"],
    itemDescription: json["item_description"],
    itemLink: json["item__link"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}