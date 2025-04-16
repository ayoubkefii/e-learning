import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Submit quiz results
  Future<void> submitQuizResults({
    required String userId,
    required String courseId,
    required String moduleId,
    required String quizId,
    required int score,
    required int totalQuestions,
    required List<String> correctAnswers,
    required List<String> userAnswers,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('quizResults')
        .add({
      'courseId': courseId,
      'moduleId': moduleId,
      'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'userAnswers': userAnswers,
      'submittedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get user's quiz results for a specific course
  Stream<QuerySnapshot> getUserQuizResults(String userId, String courseId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('quizResults')
        .where('courseId', isEqualTo: courseId)
        .snapshots();
  }

  // Create a new quiz (for trainers)
  Future<String> createQuiz({
    required String courseId,
    required String moduleId,
    required String title,
    required String description,
    required List<Question> questions,
    required int timeLimit,
    required int passingScore,
  }) async {
    DocumentReference quizRef = await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .collection('quizzes')
        .add({
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
      'timeLimit': timeLimit,
      'passingScore': passingScore,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Update module with quiz reference
    await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .update({'quizId': quizRef.id});

    return quizRef.id;
  }

  // Get quiz statistics
  Future<Map<String, dynamic>> getQuizStatistics(
      String courseId, String moduleId, String quizId) async {
    QuerySnapshot results = await _firestore
        .collectionGroup('quizResults')
        .where('courseId', isEqualTo: courseId)
        .where('moduleId', isEqualTo: moduleId)
        .where('quizId', isEqualTo: quizId)
        .get();

    int totalAttempts = results.docs.length;
    int passingAttempts = results.docs
        .where((doc) =>
            (doc.data() as Map<String, dynamic>)['score'] >=
            (doc.data() as Map<String, dynamic>)['passingScore'])
        .length;

    double averageScore = results.docs.isEmpty
        ? 0
        : results.docs.fold<double>(
                0,
                (sum, doc) =>
                    sum + (doc.data() as Map<String, dynamic>)['score']) /
            totalAttempts;

    return {
      'totalAttempts': totalAttempts,
      'passingAttempts': passingAttempts,
      'averageScore': averageScore,
      'passRate': totalAttempts == 0
          ? 0
          : (passingAttempts / totalAttempts) * 100,
    };
  }
} 