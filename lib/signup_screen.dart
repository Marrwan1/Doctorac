import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'Home.dart' show HomePage;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const String _logo = 'assets/logo/logo_text1.png';

  static const Color _blue = Color(0xFF0A5FE0);
  static const Color _blueLight = Color(0xFF2B8CFF);
  static const Color _navy = Color(0xFF0B1F4D);
  static const Color _grey = Color(0xFF6B7A90);
  static const Color _border = Color(0xFFDCE6F5);
  static const Color _bg1 = Color(0xFFFAFCFF);
  static const Color _bg2 = Color(0xFFE9F1FF);

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _hidePass = true;
  bool _hideConfirm = true;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _createAccount() async {
    if (_loading || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    try {
      await AuthService.signUp(
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        phone: _phoneCtrl.text,
        password: _passCtrl.text,
      );
      if (!mounted) return;
      _snack('تم إنشاء الحساب بنجاح');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
        (_) => false,
      );
    } on AuthException catch (e) {
      if (mounted) _snack(e.message);
    } catch (_) {
      if (mounted) _snack('حصل خطأ غير متوقع، حاول مرة أخرى');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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

  Widget _eye(bool hidden, VoidCallback onTap) {
    return IconButton(
      icon: Icon(
        hidden ? Icons.visibility_off : Icons.visibility,
        size: 20,
        color: _grey,
      ),
      onPressed: onTap,
    );
  }

  Widget _link(String text) {
    return GestureDetector(
      onTap: () {
        // TODO: افتحي صفحة الشروط / الخصوصية
      },
      child: Text(
        text,
        style: const TextStyle(
          color: _blue,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String hint,
    IconData icon,
    String? Function(String?) validator, {
    TextInputType? type,
    bool ltr = false,
    bool obscure = false,
    Widget? suffix,
    TextInputAction action = TextInputAction.next,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      obscureText: obscure,
      textInputAction: action,
      textDirection: ltr ? TextDirection.ltr : null,
      decoration: _input(hint, icon, suffix: suffix),
      validator: validator,
      onFieldSubmitted: action == TextInputAction.done
          ? (_) => _createAccount()
          : null,
    );
  }

  Widget _mainButton() {
    return GestureDetector(
      onTap: _loading ? null : _createAccount,
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
        child: _loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'إنشاء الحساب',
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
        onPressed: () => _snack('التسجيل عبر Google هيتفعّل قريباً'),
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
            Text(
              'G',
              style: TextStyle(
                color: Color(0xFF4285F4),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'الاشتراك عبر Google',
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
              'إنشاء حساب جديد',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _navy,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'يرجى إدخال بياناتك للبدء واستخدام جميع مزايا التطبيق',
              textAlign: TextAlign.center,
              style: TextStyle(color: _grey, fontSize: 13, height: 1.5),
            ),
            SizedBox(height: gap * 1.4),
            _field(
              _nameCtrl,
              'الاسم الكامل',
              Icons.person_outline,
              (v) => (v == null || v.trim().length < 3)
                  ? 'اكتب اسمك الكامل'
                  : null,
            ),
            SizedBox(height: gap),
            _field(
              _emailCtrl,
              'البريد الإلكتروني',
              Icons.mail_outline,
              (v) {
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                    .hasMatch((v ?? '').trim());
                return ok ? null : 'اكتب بريد إلكتروني صحيح';
              },
              type: TextInputType.emailAddress,
              ltr: true,
            ),
            SizedBox(height: gap),
            _field(
              _phoneCtrl,
              'رقم الهاتف',
              Icons.phone_outlined,
              (v) => (v == null || v.trim().length < 10)
                  ? 'اكتب رقم هاتف صحيح'
                  : null,
              type: TextInputType.phone,
              ltr: true,
            ),
            SizedBox(height: gap),
            _field(
              _passCtrl,
              'كلمة المرور',
              Icons.lock_outline,
              (v) => (v == null || v.length < 6)
                  ? 'كلمة المرور 6 أحرف على الأقل'
                  : null,
              obscure: _hidePass,
              suffix: _eye(
                _hidePass,
                () => setState(() => _hidePass = !_hidePass),
              ),
            ),
            SizedBox(height: gap),
            _field(
              _confirmCtrl,
              'تأكيد كلمة المرور',
              Icons.lock_outline,
              (v) => v != _passCtrl.text ? 'كلمتا المرور غير متطابقتين' : null,
              obscure: _hideConfirm,
              action: TextInputAction.done,
              suffix: _eye(
                _hideConfirm,
                () => setState(() => _hideConfirm = !_hideConfirm),
              ),
            ),
            SizedBox(height: gap * 1.8),
            _mainButton(),
            SizedBox(height: gap),
            _orDivider(),
            SizedBox(height: gap),
            _googleButton(),
            SizedBox(height: gap * 1.4),
            const Text(
              'بإنشاء حسابك، فإنك توافق على',
              textAlign: TextAlign.center,
              style: TextStyle(color: _grey, fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _link('شروط الاستخدام'),
                const Text(
                  '  و  ',
                  style: TextStyle(color: _grey, fontSize: 12),
                ),
                _link('سياسة الخصوصية'),
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
                      child: CustomPaint(painter: _WavePainter()),
                    ),
                  ),
                  SafeArea(
                    child: LayoutBuilder(
                      builder: (context, box) {
                        final gap = (box.maxHeight * 0.017).clamp(7.0, 14.0);
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () => Navigator.maybePop(context),
                                icon: const Icon(
                                  Icons.chevron_left,
                                  size: 32,
                                  color: _navy,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: _form(box.maxWidth - 48, gap),
                                ),
                              ),
                            ),
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
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.05,
          size.width * 0.6, size.height * 0.35)
      ..quadraticBezierTo(
          size.width * 0.85, size.height * 0.6, size.width, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final p2 = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.4,
          size.width * 0.7, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.85, size.width, size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(p1, back);
    canvas.drawPath(p2, front);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
