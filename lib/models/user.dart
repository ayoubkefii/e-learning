class User {
  final String id;
  final String email;
  final String name;
  final String role; // 'learner' or 'trainer'
  final String? profileImage;
  final List<String> enrolledCourses;
  final List<String> completedCourses;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profileImage,
    this.enrolledCourses = const [],
    this.completedCourses = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      profileImage: json['profileImage'] as String?,
      enrolledCourses: List<String>.from(json['enrolledCourses'] ?? []),
      completedCourses: List<String>.from(json['completedCourses'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profileImage': profileImage,
      'enrolledCourses': enrolledCourses,
      'completedCourses': completedCourses,
    };
  }
} 