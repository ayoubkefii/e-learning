import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/module.dart';
import '../models/lesson.dart';
import '../models/quiz.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all courses
  Stream<QuerySnapshot> getCourses() {
    return _firestore.collection('courses').snapshots();
  }

  // Get course by ID
  Future<DocumentSnapshot> getCourseById(String courseId) {
    return _firestore.collection('courses').doc(courseId).get();
  }

  // Get modules for a course
  Stream<QuerySnapshot> getModules(String courseId) {
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .orderBy('order')
        .snapshots();
  }

  // Get module by ID
  Future<Module> getModuleById(String courseId, String moduleId) async {
    DocumentSnapshot doc = await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .get();

    return Module.fromJson(doc.data() as Map<String, dynamic>);
  }

  // Get lessons for a module
  Stream<QuerySnapshot> getLessons(String courseId, String moduleId) {
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .collection('lessons')
        .orderBy('order')
        .snapshots();
  }

  // Get lesson by ID
  Future<Lesson> getLessonById(
      String courseId, String moduleId, String lessonId) async {
    DocumentSnapshot doc = await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .collection('lessons')
        .doc(lessonId)
        .get();

    return Lesson.fromJson(doc.data() as Map<String, dynamic>);
  }

  // Get quiz for a module
  Future<Quiz?> getQuiz(String courseId, String moduleId) async {
    DocumentSnapshot moduleDoc = await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .get();

    Module module = Module.fromJson(moduleDoc.data() as Map<String, dynamic>);
    if (module.quizId == null) return null;

    DocumentSnapshot quizDoc = await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .collection('quizzes')
        .doc(module.quizId)
        .get();

    return Quiz.fromJson(quizDoc.data() as Map<String, dynamic>);
  }

  // Enroll in a course
  Future<void> enrollInCourse(String userId, String courseId) async {
    await _firestore.collection('users').doc(userId).update({
      'enrolledCourses': FieldValue.arrayUnion([courseId])
    });
  }

  // Mark course as completed
  Future<void> completeCourse(String userId, String courseId) async {
    await _firestore.collection('users').doc(userId).update({
      'enrolledCourses': FieldValue.arrayRemove([courseId]),
      'completedCourses': FieldValue.arrayUnion([courseId])
    });
  }

  // Create a new course (for trainers)
  Future<void> createCourse({
    required String title,
    required String description,
    required String trainerId,
    required String category,
    required String level,
    required String imageUrl,
  }) async {
    await _firestore.collection('courses').add({
      'title': title,
      'description': description,
      'trainerId': trainerId,
      'category': category,
      'level': level,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
} 