class PostModel {
  int userId;
  int id;
  String body;
  String title;
  PostModel(
      {required this.body,
      required this.id,
      required this.title,
      required this.userId});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["userId"],
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userId": userId,
        "body": body,
      };
}
