class NotificationModel {
  String title;
  String description;
  DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static NotificationModel fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
