class Quiz {
  final String id;
  final String title;
  final String description;
  final String moduleId;
  final List<Question> questions;
  final int timeLimit; // in minutes
  final int passingScore; // percentage

  Quiz({
    required this.id,   
    required this.title,
    required this.description,
    required this.moduleId,
    required this.questions,
    required this.timeLimit,
    required this.passingScore,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      moduleId: json['moduleId'] as String,
      questions: (json['questions'] as List)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeLimit: json['timeLimit'] as int,
      passingScore: json['passingScore'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'moduleId': moduleId,
      'questions': questions.map((e) => e.toJson()).toList(),
      'timeLimit': timeLimit,
      'passingScore': passingScore,
    };
  }
}

class Question {
  final String id;
  final String text;
  final List<Answer> answers;
  final String? explanation;
  final int points;

  Question({
    required this.id,
    required this.text,
    required this.answers,
    this.explanation,
    required this.points,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      text: json['text'] as String,
      answers: (json['answers'] as List)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      explanation: json['explanation'] as String?,
      points: json['points'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'answers': answers.map((e) => e.toJson()).toList(),
      'explanation': explanation,
      'points': points,
    };
  }
}

class Answer {
  final String id;
  final String text;
  final bool isCorrect;

  Answer({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as String,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
    };
  }
} 