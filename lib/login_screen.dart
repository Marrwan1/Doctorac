import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'Home.dart' show HomePage;
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _logo = 'assets/logo/logo_text1.png';

  static const Color _blue = Color(0xFF0A5FE0);
  static const Color _blueLight = Color(0xFF2B8CFF);
  static const Color _navy = Color(0xFF0B1F4D);
  static const Color _grey = Color(0xFF6B7A90);
  static const Color _border = Color(0xFFDCE6F5);
  static const Color _bg1 = Color(0xFFFAFCFF);
  static const Color _bg2 = Color(0xFFE9F1FF);

  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hidePass = true;

  @override
  void dispose() {
    _idCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // TODO: اربطي هنا بالـ backend / Firebase
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  void _openSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  InputDecoration _input(String hint, IconData icon, {Widget? suffix}) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: c),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _grey, fontSize: 14),
      prefixIcon: Icon(icon, color: _blue, size: 22),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      enabledBorder: b(_border),
      focusedBorder: b(_blue),
      errorBorder: b(Colors.redAccent),
      focusedErrorBorder: b(Colors.redAccent),
    );
  }

  Widget _mainButton() {
    return GestureDetector(
      onTap: _login,
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_blue, _blueLight]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _blue.withValues(alpha: 0.3),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تسجيل الدخول',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _orDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: _border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('أو', style: TextStyle(color: _grey, fontSize: 13)),
        ),
        Expanded(child: Divider(color: _border)),
      ],
    );
  }

  Widget _googleButton() {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          // TODO: تسجيل الدخول بحساب Google
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _border, width: 1.5),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GoogleLogo(),
            SizedBox(width: 10),
            Text(
              'المتابعة عبر Google',
              style: TextStyle(
                color: _navy,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(double width, double gap) {
    return SizedBox(
      width: width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Image.asset(_logo, height: 56)),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                'رعايتك الصحية .. أسهل',
                style: TextStyle(color: _grey, fontSize: 13),
              ),
            ),
            SizedBox(height: gap * 1.8),
            const Text(
              'مرحباً بك مجدداً',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _navy,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'سجل دخولك للمتابعة مع أطبائك\nواحجز مواعيدك بسهولة',
              textAlign: TextAlign.center,
              style: TextStyle(color: _grey, fontSize: 13, height: 1.5),
            ),
            SizedBox(height: gap * 1.4),
            TextFormField(
              controller: _idCtrl,
              textInputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              decoration: _input(
                'البريد الإلكتروني أو رقم الهاتف',
                Icons.mail_outline,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'اكتب البريد أو رقم الهاتف'
                  : null,
            ),
            SizedBox(height: gap),
            TextFormField(
              controller: _passCtrl,
              obscureText: _hidePass,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _login(),
              decoration: _input(
                'كلمة المرور',
                Icons.lock_outline,
                suffix: IconButton(
                  icon: Icon(
                    _hidePass ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: _grey,
                  ),
                  onPressed: () => setState(() => _hidePass = !_hidePass),
                ),
              ),
              validator: (v) =>
              (v == null || v.isEmpty) ? 'اكتب كلمة المرور' : null,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () {
                  // TODO: صفحة استرجاع كلمة المرور
                },
                child: const Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: _blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: gap * 0.4),
            _mainButton(),
            SizedBox(height: gap),
            _orDivider(),
            SizedBox(height: gap),
            _googleButton(),
            SizedBox(height: gap * 1.4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ليس لديك حساب؟ ',
                  style: TextStyle(color: _grey, fontSize: 13),
                ),
                GestureDetector(
                  onTap: _openSignUp,
                  child: const Text(
                    'إنشاء حساب جديد',
                    style: TextStyle(
                      color: _blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: gap),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
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
                      child: CustomPaint(painter: _WavePainter()),
                    ),
                  ),
                  SafeArea(
                    child: LayoutBuilder(
                      builder: (context, box) {
                        final gap =
                        (box.maxHeight * 0.022).clamp(8.0, 20.0);
                        return Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: _form(box.maxWidth - 48, gap),
                          ),
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
}

class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width * 0.22;
    final r = (size.width - w) / 2;
    final c = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: c, radius: r);

    double rad(double d) => d * math.pi / 180;

    Paint ring(Color col) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..color = col;

    const red = Color(0xFFEA4335);
    const yellow = Color(0xFFFBBC05);
    const green = Color(0xFF34A853);
    const blue = Color(0xFF4285F4);

    canvas.drawArc(rect, rad(-40), rad(-100), false, ring(red));
    canvas.drawArc(rect, rad(-140), rad(-80), false, ring(yellow));
    canvas.drawArc(rect, rad(140), rad(-95), false, ring(green));
    canvas.drawArc(rect, rad(45), rad(-50), false, ring(blue));

    canvas.drawRect(
      Rect.fromLTRB(c.dx, c.dy - w / 2, size.width, c.dy + w / 2),
      Paint()..color = blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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