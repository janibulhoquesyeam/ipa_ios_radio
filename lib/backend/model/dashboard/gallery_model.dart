class GalleryModel {
  final Data data;

  GalleryModel({
    required this.data,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String baseUrl;
  final String imagePath;
  final List<Gallery> galleries;

  Data({
    required this.baseUrl,
    required this.imagePath,
    required this.galleries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
    galleries: List<Gallery>.from(json["galleries"].map((x) => Gallery.fromJson(x))),
  );
}

class Gallery {
  final String id;
  final String image;

  Gallery({
    required this.id,
    required this.image,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    id: json["id"],
    image: json["image"],
  );
}