import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      // TODO: اربطي هنا بالـ backend / Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إنشاء الحساب', style: GoogleFonts.cairo())),
      );
    }
  }

  InputDecoration _input(String hint, IconData icon, {Widget? suffix}) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: c),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.cairo(fontSize: 14, color: Colors.black45),
      prefixIcon: Icon(icon, color: _blue, size: 22),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      enabledBorder: b(_border),
      focusedBorder: b(_blue),
      errorBorder: b(Colors.redAccent),
      focusedErrorBorder: b(Colors.redAccent),
      errorStyle: GoogleFonts.cairo(fontSize: 12),
    );
  }

  Widget _eye(bool hidden, VoidCallback onTap) {
    return IconButton(
      icon: Icon(hidden ? Icons.visibility_off : Icons.visibility, size: 20),
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
        style: GoogleFonts.cairo(
          fontSize: 12,
          color: _blue,
          decoration: TextDecoration.underline,
          decorationColor: _blue,
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
    );
  }

  Widget _mainButton() {
    return GestureDetector(
      onTap: _createAccount,
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_blue, _blueLight]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _blue.withOpacity(0.3),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'إنشاء الحساب',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _orDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: _border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('أو', style: GoogleFonts.cairo(color: _grey)),
        ),
        const Expanded(child: Divider(color: _border)),
      ],
    );
  }

  Widget _googleButton() {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          // TODO: التسجيل بحساب Google
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _border, width: 1.5),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'G',
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFEA4335),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'الاشتراك عبر Google',
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
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
            Center(
              child: Text(
                'رعايتك الصحية .. أسهل',
                style: GoogleFonts.cairo(fontSize: 14, color: _navy),
              ),
            ),
            SizedBox(height: gap * 1.8),
            Text(
              'إنشاء حساب جديد',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: _navy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'يرجى إدخال بياناتك للبدء واستخدام جميع مزايا التطبيق',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 13, color: _grey, height: 1.6),
            ),
            SizedBox(height: gap * 1.4),
            _field(
              _nameCtrl,
              'الاسم الكامل',
              Icons.person_outline,
                  (v) => (v == null || v.trim().length < 3)
                  ? 'اكتبي اسمك الكامل'
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
                return ok ? null : 'اكتبي بريد إلكتروني صحيح';
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
                  ? 'اكتبي رقم هاتف صحيح'
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
            Text(
              'بإنشاء حسابك، فإنك توافق على',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 12, color: _grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _link('شروط الاستخدام'),
                Text(
                  '  و  ',
                  style: GoogleFonts.cairo(fontSize: 12, color: _grey),
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
    final back = Paint()..color = const Color(0xFFD6E6FB).withOpacity(0.7);
    final front = Paint()..color = const Color(0xFFBFD8F8).withOpacity(0.5);

    final p1 = Path()
      ..moveTo(0, size.height * 0.45)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.05,
          size.width * 0.6, size.height * 0.35)
      ..quadraticBezierTo(size.width * 0.85, size.height * 0.6, size.width,
          size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final p2 = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.4,
          size.width * 0.7, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.85, size.width,
          size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(p1, back);
    canvas.drawPath(p2, front);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}