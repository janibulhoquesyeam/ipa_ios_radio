
class BasicSettingsModel {
  final Data data;
  final String type;

  BasicSettingsModel({
    required this.data,
    required this.type,
  });

  factory BasicSettingsModel.fromJson(Map<String, dynamic> json) => BasicSettingsModel(
    data: Data.fromJson(json["data"]),
    type: json["type"],
  );
}

class Data {
  final BasicSettings basicSettings;
  final AllLogo allLogo;
  final WebLinks webLinks;
  // final List<Language> languages;
  final List<SplashScreen> splashScreen;
  final List<OnboardScreen> onboardScreens;
  final ImagePaths imagePaths;
  final AppImagePaths appImagePaths;

  Data({
    required this.basicSettings,
    required this.allLogo,
    required this.webLinks,
    // required this.languages,
    required this.splashScreen,
    required this.onboardScreens,
    required this.imagePaths,
    required this.appImagePaths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    basicSettings: BasicSettings.fromJson(json["basic_settings"]),
    allLogo: AllLogo.fromJson(json["all_logo"]),
    webLinks: WebLinks.fromJson(json["web_links"]),
    // languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    splashScreen: List<SplashScreen>.from(json["splash_screen"].map((x) => SplashScreen.fromJson(x))),
    onboardScreens: List<OnboardScreen>.from(json["onboard_screens"].map((x) => OnboardScreen.fromJson(x))),
    imagePaths: ImagePaths.fromJson(json["image_paths"]),
    appImagePaths: AppImagePaths.fromJson(json["app_image_paths"]),
  );
}

class AllLogo {
  final String siteLogoDark;
  final String siteLogo;
  final String siteFavDark;
  final String siteFav;

  AllLogo({
    required this.siteLogoDark,
    required this.siteLogo,
    required this.siteFavDark,
    required this.siteFav,
  });

  factory AllLogo.fromJson(Map<String, dynamic> json) => AllLogo(
    siteLogoDark: json["site_logo_dark"],
    siteLogo: json["site_logo"],
    siteFavDark: json["site_fav_dark"],
    siteFav: json["site_fav"],
  );
}

class AppImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  AppImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory AppImagePaths.fromJson(Map<String, dynamic> json) => AppImagePaths(
    baseUrl: json["base_url"],
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
  );
}

class BasicSettings {
  final int id;
  final String siteName;
  final String siteTitle;
  final String baseColor;
  final String secondaryColor;
  final String timezone;

  BasicSettings({
    required this.id,
    required this.siteName,
    required this.siteTitle,
    required this.timezone,
    required this.baseColor,
    required this.secondaryColor
  });

  factory BasicSettings.fromJson(Map<String, dynamic> json) => BasicSettings(
    id: json["id"],
    siteName: json["site_name"],
    siteTitle: json["site_title"],
    timezone: json["timezone"],
    baseColor: json["base_color"],
    secondaryColor: json["secondary_color"],
  );
}

class ImagePaths {
  final String basePath;
  final String pathLocation;
  final String defaultImage;

  ImagePaths({
    required this.basePath,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory ImagePaths.fromJson(Map<String, dynamic> json) => ImagePaths(
    basePath: json["base_url"],
    pathLocation: json["path_location"],
    defaultImage: json["default_image"],
  );
}

class OnboardScreen {
  final String title;
  final String subTitle;
  final String image;
  final int status;

  OnboardScreen({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
    title: json["title"] ?? "",
    subTitle: json["sub_title"] ?? "",
    image: json["image"],
    status: json["status"],
  );
}

class SplashScreen {
  final String image;
  final String version;

  SplashScreen({
    required this.image,
    required this.version,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
    image: json["image"] ?? "",
    version: json["version"],
  );
}

class WebLinks {
  final String privacyPolicy;
  final String aboutUs;
  final String contactUs;
  final String blog;

  WebLinks({
    required this.privacyPolicy,
    required this.aboutUs,
    required this.contactUs,
    required this.blog,
  });

  factory WebLinks.fromJson(Map<String, dynamic> json) => WebLinks(
    privacyPolicy: json["privacy-policy"],
    aboutUs: json["about-us"],
    contactUs: json["contact-us"],
    blog: json["blog"],
  );
}