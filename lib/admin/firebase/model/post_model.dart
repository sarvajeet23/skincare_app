class Post {
  String? id;
  String? title;
  String? subtitle;
  String? details;
  String? image;
  bool? isDone;
  DateTime? time;

  Post({
    this.id,
    this.title,
    this.subtitle,
    this.details,
    this.image,
    this.time,
    this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'details': details,
      'image': image,
      'time': time?.toIso8601String(),
      'isDone': isDone,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      details: map['details'] ?? '',
      image: map['image'] ?? '',
      time: map['time'] != null ? DateTime.parse(map['time']) : null,
      isDone: map['isDone'] ?? false,
    );
  }
  // Override toString for better debugging
  @override
  String toString() {
    return 'Post(id: $id, title: $title, subtitle: $subtitle, details: $details, image: $image, isDone: $isDone, time: $time)';
  }
}
