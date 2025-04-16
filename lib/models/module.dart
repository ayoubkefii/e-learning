class Module {
  final String id;
  final String title;
  final String description;
  final String courseId;
  final int order;
  final List<String> lessonIds;
  final String? quizId;
  final int estimatedDuration; // in minutes

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.order,
    this.lessonIds = const [],
    this.quizId,
    required this.estimatedDuration,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      courseId: json['courseId'] as String,
      order: json['order'] as int,
      lessonIds: List<String>.from(json['lessonIds'] ?? []),
      quizId: json['quizId'] as String?,
      estimatedDuration: json['estimatedDuration'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'courseId': courseId,
      'order': order,
      'lessonIds': lessonIds,
      'quizId': quizId,
      'estimatedDuration': estimatedDuration,
    };
  }
} 