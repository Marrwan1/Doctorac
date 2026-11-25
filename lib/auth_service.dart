import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// خطأ جاهز للعرض للمستخدم (الرسالة بالعربي).
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  @override
  String toString() => message;
}

/// كل التعامل مع Firebase في مكان واحد، عشان الصفحات تفضل نضيفة.
class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  /// بيانات المستخدم (الاسم، الهاتف...) لحظياً من Firestore.
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userStream(String uid) =>
      _userDoc(uid).snapshots();

  // ---------------- تسجيل الدخول ----------------
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_message(e.code));
    }
  }

  // ---------------- إنشاء حساب ----------------
  static Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = cred.user!;
      await user.updateDisplayName(name.trim());

      // لو حفظ البيانات في Firestore فشل (مثلاً الـ rules) الحساب يفضل متعمل
      // والبروفايل بيرجع للاسم المحفوظ في Auth.
      try {
        await _userDoc(user.uid).set({
          'name': name.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        debugPrint('Firestore user doc failed: $e');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(_message(e.code));
    }
  }

  // ---------------- تعديل البروفايل ----------------
  static Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw const AuthException('سجّل دخولك الأول');
    try {
      await user.updateDisplayName(name.trim());
      await _userDoc(user.uid).set({
        'name': name.trim(),
        'phone': phone.trim(),
        'email': user.email,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      throw AuthException(_message(e.code));
    } on FirebaseException {
      throw const AuthException('تعذر حفظ البيانات، حاول مرة أخرى');
    }
  }

  // ---------------- استرجاع كلمة المرور ----------------
  static Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_message(e.code));
    }
  }

  static Future<void> signOut() => _auth.signOut();

  // ---------------- رسائل الأخطاء ----------------
  static String _message(String code) {
    switch (code) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صحيح';
      case 'user-disabled':
        return 'تم إيقاف هذا الحساب';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'هذا البريد مسجل بالفعل';
      case 'weak-password':
        return 'كلمة المرور ضعيفة، استخدم 6 أحرف على الأقل';
      case 'network-request-failed':
        return 'تأكد من اتصالك بالإنترنت';
      case 'too-many-requests':
        return 'محاولات كتير، حاول بعد شوية';
      case 'operation-not-allowed':
        return 'تسجيل الدخول بالبريد غير مفعّل في Firebase';
      case 'requires-recent-login':
        return 'سجّل دخولك من جديد وحاول تاني';
      default:
        return 'حصل خطأ غير متوقع، حاول مرة أخرى';
    }
  }
}
