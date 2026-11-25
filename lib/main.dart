import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Home.dart' show HomePage, C;
import 'firebase_options.dart'; // بيتولد من أمر: flutterfire configure
import 'onboarding_screen.dart' show OnboardingScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Firebase بيحفظ الجلسة، فلو المستخدم مسجل قبل كده يدخل على الهوم علطول
    final loggedIn = FirebaseAuth.instance.currentUser != null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctorac',
      locale: const Locale('ar'),
      builder: (c, child) {
        final mq = MediaQuery.of(c);
        final scaler =
            mq.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.15);
        return MediaQuery(
          data: mq.copyWith(textScaler: scaler),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox(),
          ),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: C.bg,
      ),
      home: loggedIn ? const HomePage() : const OnboardingScreen(),
    );
  }
}
