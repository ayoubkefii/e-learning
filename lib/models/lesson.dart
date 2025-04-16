class Lesson {
  final String id;
  final String title;
  final String description;
  final String moduleId;
  final String content; // Can be text content or video URL
  final String contentType; // 'text' or 'video'
  final int duration; // in minutes
  final int order;
  final List<String> resources; // URLs to additional resources

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.moduleId,
    required this.content,
    required this.contentType,
    required this.duration,
    required this.order,
    this.resources = const [],
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      moduleId: json['moduleId'] as String,
      content: json['content'] as String,
      contentType: json['contentType'] as String,
      duration: json['duration'] as int,
      order: json['order'] as int,
      resources: List<String>.from(json['resources'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'moduleId': moduleId,
      'content': content,
      'contentType': contentType,
      'duration': duration,
      'order': order,
      'resources': resources,
    };
  }
} 