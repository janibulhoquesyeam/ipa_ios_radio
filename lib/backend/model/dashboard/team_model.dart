class TeamModel {
  final Data data;

  TeamModel({
    required this.data,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String baseUrl;
  final String imagePath;
  final List<Team> teams;

  Data({
    required this.baseUrl,
    required this.imagePath,
    required this.teams,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
    teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
  );
}

class Team {
  final String id;
  final String image;
  final String itemName;
  final String itemDesignation;
  final List<SocialLink> socialLinks;

  Team({
    required this.id,
    required this.image,
    required this.itemName,
    required this.itemDesignation,
    required this.socialLinks,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    image: json["image"],
    itemName: json["item_name"],
    itemDesignation: json["item_designation"],
    socialLinks: List<SocialLink>.from(json["social_links"].map((x) => SocialLink.fromJson(x))),
  );
}

class SocialLink {
  final String image;
  final String link;

  SocialLink({
    required this.image,
    required this.link,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
    image: json["icon_image"],
    link: json["link"],
  );
}