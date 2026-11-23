
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

void main() {
runApp(
const MaterialApp(
debugShowCheckedModeBanner: false,
home: OnboardingScreen(),
),
);
}

class OnboardingScreen extends StatelessWidget {
const OnboardingScreen({super.key});

static const String _image = 'assets/logo/Onboarding_image.jpg';
static const String _logo = 'assets/logo/logo_text1.png';

static const Color _blue = Color(0xFF0A5FE0);
static const Color _blueLight = Color(0xFF2B8CFF);
static const Color _navy = Color(0xFF0B1F4D);
static const Color _grey = Color(0xFF6B7A90);
static const Color _bg1 = Color(0xFFFAFCFF);
static const Color _bg2 = Color(0xFFE9F1FF);

void _openLogin(BuildContext context) {
Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (_) => const LoginScreen(),
),
);
}

void _openSignUp(BuildContext context) {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const SignUpScreen(),
),
);
}

@override
Widget build(BuildContext context) {
return Directionality(
textDirection: TextDirection.rtl,
child: Scaffold(
backgroundColor: const Color(0xFFDCE8F8),
body: Center(
child: ConstrainedBox(
constraints: const BoxConstraints(maxWidth: 430),
child: Container(
width: double.infinity,
height: double.infinity,
decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [_bg1, _bg2],
),
),
child: Stack(
children: [
const Positioned(
left: 0,
right: 0,
bottom: 0,
child: SizedBox(
height: 140,
child: CustomPaint(
painter: _WavePainter(),
),
),
),

SafeArea(
child: LayoutBuilder(
builder: (context, box) {
final h = box.maxHeight;

return Column(
children: [
SizedBox(height: h * 0.025),

Image.asset(
_logo,
height: (h * 0.07).clamp(30.0, 52.0),
),

const SizedBox(height: 2),

Text(
'رعايتك الصحية .. أسهل',
style: TextStyle(
color: _grey,
fontSize: 13,
),
),

Expanded(
child: _content(),
),

Padding(
padding: const EdgeInsets.symmetric(
horizontal: 24,
),
child: _mainButton(context, h),
),

SizedBox(
height: (h * 0.08).clamp(40.0, 56.0),
child: TextButton(
onPressed: () => _openSignUp(context),
child: Text(
'إنشاء حساب جديد',
style: TextStyle(
color: _navy,
fontSize: 14,
fontWeight: FontWeight.w600,
),
),
),
),

SizedBox(height: h * 0.015),
],
);
},
),
),
],
),
),
),
),
),
);
}

Widget _content() {
return LayoutBuilder(
builder: (context, box) {
final availH = box.maxHeight;
final availW = box.maxWidth;

final imageSize = math.min(
availW * 0.72,
availH * 0.42,
);

final titleSize = (availH * 0.075).clamp(18.0, 28.0);
final descSize = (availH * 0.04).clamp(11.0, 15.0);

return Center(
child: FittedBox(
fit: BoxFit.scaleDown,
child: SizedBox(
width: availW,
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Container(
width: imageSize,
height: imageSize,
decoration: BoxDecoration(
shape: BoxShape.circle,
boxShadow: [
BoxShadow(
color: _blue.withValues(alpha: 0.18),
blurRadius: 30,
spreadRadius: 4,
),
],
),
child: ClipOval(
child: Image.asset(
_image,
fit: BoxFit.cover,
errorBuilder: (_, __, ___) => const Icon(
Icons.health_and_safety,
size: 110,
color: _blue,
),
),
),
),

SizedBox(height: availH * 0.04),

Text(
'اصحى على\nصحتك دايماً',
textAlign: TextAlign.center,
style: TextStyle(
color: _navy,
fontSize: titleSize,
fontWeight: FontWeight.bold,
height: 1.5,
),
),

SizedBox(height: availH * 0.015),

Text(
'احجز مع أفضل الأطباء والمراكز الطبية\nبكل سهولة وأمان',
textAlign: TextAlign.center,
style: TextStyle(
color: _grey,
fontSize: descSize,
height: 1.7,
),
),

const SizedBox(height: 16),
],
),
),
),
);
},
);
}

Widget _mainButton(BuildContext context, double h) {
return GestureDetector(
onTap: () => _openLogin(context),
child: Container(
height: (h * 0.07).clamp(46.0, 56.0),
alignment: Alignment.center,
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [_blue, _blueLight],
),
borderRadius: BorderRadius.circular(30),
boxShadow: [
BoxShadow(
color: _blue.withValues(alpha: 0.3),
blurRadius: 14,
offset: const Offset(0, 6),
),
],
),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text(
'ابدأ الآن',
style: TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),

const SizedBox(width: 8),

const Icon(
Icons.arrow_back,
color: Colors.white,
size: 20,
),
],
),
),
);
}
}

class _WavePainter extends CustomPainter {
const _WavePainter();

@override
void paint(Canvas canvas, Size size) {
final back = Paint()
..color = const Color(0xFFD6E6FB).withValues(alpha: 0.7);

final front = Paint()
..color = const Color(0xFFBFD8F8).withValues(alpha: 0.5);

final p1 = Path()
..moveTo(0, size.height * 0.45)
..quadraticBezierTo(
size.width * 0.3,
size.height * 0.05,
size.width * 0.6,
size.height * 0.35,
)
..quadraticBezierTo(
size.width * 0.85,
size.height * 0.6,
size.width,
size.height * 0.3,
)
..lineTo(size.width, size.height)
..lineTo(0, size.height)
..close();

final p2 = Path()
..moveTo(0, size.height * 0.7)
..quadraticBezierTo(
size.width * 0.35,
size.height * 0.4,
size.width * 0.7,
size.height * 0.7,
)
..quadraticBezierTo(
size.width * 0.9,
size.height * 0.85,
size.width,
size.height * 0.6,
)
..lineTo(size.width, size.height)
..lineTo(0, size.height)
..close();

canvas.drawPath(p1, back);
canvas.drawPath(p2, front);
}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
