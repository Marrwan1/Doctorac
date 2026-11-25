import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'Home.dart' show C, cardDeco;
import 'login_screen.dart';

/// تاب "حسابي" — بيتحط جوه الـ IndexedStack في HomePage (من غير Scaffold
/// ولا bottom nav لأن الهوم عنده الاتنين).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _danger = Color(0xFFE11D48);

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    if (user == null) return _signedOut(context);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: AuthService.userStream(user.uid),
      builder: (context, snap) {
        final data = snap.data?.data() ?? const <String, dynamic>{};
        final stored = (data['name'] as String?)?.trim() ?? '';
        final name = stored.isNotEmpty
            ? stored
            : ((user.displayName ?? '').trim().isNotEmpty
                ? user.displayName!.trim()
                : 'مستخدم');
        final email = user.email ?? (data['email'] as String? ?? '');
        final phone = (data['phone'] as String?)?.trim() ?? '';

        return ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
          children: [
            const Text(
              'حسابي',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: C.text),
            ),
            const SizedBox(height: 16),
            _headerCard(name, email),
            const SizedBox(height: 20),
            const Text(
              'بياناتي',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w800, color: C.text),
            ),
            const SizedBox(height: 12),
            _infoCard(context, name, email, phone),
            const SizedBox(height: 20),
            const Text(
              'الإعدادات',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w800, color: C.text),
            ),
            const SizedBox(height: 12),
            _actionsCard(context, email),
          ],
        );
      },
    );
  }

  // ---------------- بطاقة الاسم والصورة ----------------
  Widget _headerCard(String name, String email) {
    final initial = name.isNotEmpty && name != 'مستخدم' ? name.characters.first : '';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: cardDeco(r: 22),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              color: C.circle,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: initial.isEmpty
                ? const Icon(Icons.person, color: C.primary, size: 44)
                : Text(
                    initial,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: C.primary),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.w800, color: C.text),
          ),
          if (email.isNotEmpty) ...[
            const SizedBox(height: 4),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                email,
                style: const TextStyle(fontSize: 13, color: C.grey),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------- بطاقة البيانات ----------------
  Widget _infoCard(
      BuildContext context, String name, String email, String phone) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDeco(r: 20),
      child: Column(
        children: [
          _infoRow(Icons.person_outline_rounded, 'الاسم', name),
          const _Sep(),
          _infoRow(Icons.mail_outline_rounded, 'البريد الإلكتروني', email,
              ltr: true),
          const _Sep(),
          _infoRow(Icons.phone_outlined, 'رقم الهاتف',
              phone.isEmpty ? 'غير مضاف' : phone,
              ltr: phone.isNotEmpty),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => _openEdit(context, name, phone),
              icon: const Icon(Icons.edit_outlined, size: 20),
              label: const Text(
                'تعديل البيانات',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: C.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {bool ltr = false}) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration:
              const BoxDecoration(color: C.circle, shape: BoxShape.circle),
          child: Icon(icon, color: C.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: C.grey)),
              const SizedBox(height: 2),
              Directionality(
                textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: C.text),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- الإعدادات ----------------
  Widget _actionsCard(BuildContext context, String email) {
    return Container(
      decoration: cardDeco(r: 20),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _actionTile(
            icon: Icons.lock_reset_rounded,
            title: 'تغيير كلمة المرور',
            subtitle: 'هنبعت لك رابط على بريدك',
            onTap: () => _resetPassword(context, email),
          ),
          const Divider(height: 1, color: Color(0xFFE3E9F2)),
          _actionTile(
            icon: Icons.logout_rounded,
            title: 'تسجيل الخروج',
            color: _danger,
            circle: const Color(0xFFFEE7EC),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color color = C.primary,
    Color circle = C.circle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: circle, shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: color == C.primary ? C.text : color),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(fontSize: 12, color: C.grey)),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_left, color: C.grey),
          ],
        ),
      ),
    );
  }

  // ---------------- أفعال ----------------
  Future<void> _resetPassword(BuildContext context, String email) async {
    if (email.isEmpty) {
      _snack(context, 'مفيش بريد إلكتروني مسجل للحساب');
      return;
    }
    try {
      await AuthService.sendPasswordReset(email);
      if (context.mounted) {
        _snack(context, 'بعتنا رابط تغيير كلمة المرور على بريدك');
      }
    } on AuthException catch (e) {
      if (context.mounted) _snack(context, e.message);
    }
  }

  Future<void> _logout(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('تسجيل الخروج',
              style: TextStyle(fontWeight: FontWeight.w800, color: C.text)),
          content: const Text('متأكد إنك عايز تخرج من حسابك؟',
              style: TextStyle(color: C.grey)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('إلغاء', style: TextStyle(color: C.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('خروج',
                  style: TextStyle(
                      color: _danger, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
    if (ok != true) return;
    await AuthService.signOut();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  void _openEdit(BuildContext context, String name, String phone) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: _EditSheet(name: name == 'مستخدم' ? '' : name, phone: phone),
      ),
    );
  }

  Widget _signedOut(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration:
                const BoxDecoration(color: C.circle, shape: BoxShape.circle),
            child: const Icon(Icons.account_circle_outlined,
                color: C.primary, size: 38),
          ),
          const SizedBox(height: 14),
          const Text('سجّل دخولك لعرض حسابك',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w800, color: C.text)),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: C.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: const Text('تسجيل الدخول',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _Sep extends StatelessWidget {
  const _Sep();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1, color: Color(0xFFE3E9F2)),
      );
}

// ======================= شيت تعديل البيانات =======================
class _EditSheet extends StatefulWidget {
  final String name;
  final String phone;
  const _EditSheet({required this.name, required this.phone});

  @override
  State<_EditSheet> createState() => _EditSheetState();
}

class _EditSheetState extends State<_EditSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl =
      TextEditingController(text: widget.name);
  late final TextEditingController _phoneCtrl =
      TextEditingController(text: widget.phone);
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  InputDecoration _input(String hint, IconData icon) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: c),
        );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: C.grey, fontSize: 14),
      prefixIcon: Icon(icon, color: C.primary, size: 22),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      enabledBorder: b(const Color(0xFFDCE6F5)),
      focusedBorder: b(C.primary),
      errorBorder: b(Colors.redAccent),
      focusedErrorBorder: b(Colors.redAccent),
    );
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    try {
      await AuthService.updateProfile(
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
      );
      navigator.pop();
      messenger.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('تم حفظ التعديلات'),
      ));
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        messenger.showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 24 + bottom),
      decoration: const BoxDecoration(
        color: C.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCFDDF2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'تعديل البيانات',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w800, color: C.text),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameCtrl,
              textInputAction: TextInputAction.next,
              decoration: _input('الاسم الكامل', Icons.person_outline),
              validator: (v) => (v == null || v.trim().length < 3)
                  ? 'اكتب اسمك الكامل'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              decoration: _input('رقم الهاتف', Icons.phone_outlined),
              validator: (v) => (v == null || v.trim().length < 10)
                  ? 'اكتب رقم هاتف صحيح'
                  : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: C.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.5, color: Colors.white),
                      )
                    : const Text('حفظ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
