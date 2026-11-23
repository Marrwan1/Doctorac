import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const DoctoracApp());
}

// ── Icons: Material icons stand in for the SVG assets (no packages needed) ──
const _icons = <String, IconData>{
  'arrow-left': Icons.arrow_back,
  'note-text': Icons.assignment_outlined,
  'user': Icons.person_outline,
  'phone': Icons.phone_outlined,
  'medical-clipboard': Icons.medical_information_outlined,
  'location-1': Icons.location_on_outlined,
  'calendar-check': Icons.event_available_outlined,
  'chevron-down': Icons.keyboard_arrow_down,
};

/// Same call style as flutter_svg's `SvgPicture.asset`, but backed by
/// Material icons so no package or asset files are needed.
class SvgIcon {
  static Widget asset(String path,
      {double? width, double? height, Color? color}) {
    final name = path.split('/').last.replaceAll('.svg', '');
    return Icon(_icons[name] ?? Icons.circle_outlined,
        size: width ?? height, color: color);
  }
}

// ═════════════════════════════════════════════════════════════════════
// IMPORTANT: keep your original base64 string here (the long JPEG text
// between the ''' marks). Replace ONLY the PASTE_YOUR_BASE64_HERE line.
// If it is left as is, the app still runs and shows a plain blue banner.
// ═════════════════════════════════════════════════════════════════════
const _bannerB64 = r'''
PASTE_YOUR_BASE64_HERE
''';

Uint8List? _decodeBanner() {
  try {
    return base64Decode(_bannerB64.replaceAll(RegExp(r'\s'), ''));
  } catch (_) {
    return null;
  }
}

final Uint8List? _bannerBytes = _decodeBanner();

// ───────────────────────── Colors ─────────────────────────
class C {
  static const navy = Color(0xFF14285A);
  static const ink = Color(0xFF1C2F5C);
  static const mute = Color(0xFFA3B0C4);
  static const blue = Color(0xFF1A6FE8);
  static const border = Color(0xFFD6E1F0);
  static const icon = Color(0xFF2C4A82);
  static const error = Color(0xFFD93A4A);
}

// ───────────────────────── App ─────────────────────────
class DoctoracApp extends StatelessWidget {
  const DoctoracApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctorac',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: C.blue),
      ),
      // The whole app is right-to-left (Arabic).
      builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl, child: child ?? const SizedBox()),
      home: const HomeCareScreen(),
    );
  }
}

// ───────────────────────── Data ─────────────────────────
class Option {
  final String label;
  final IconData? icon;
  const Option(this.label, [this.icon]);
}

const services = <Option>[
  Option('خدمات إسعاف طوارئ', Icons.emergency_outlined),
  Option('خدمات طب الأسنان المنزلية', Icons.health_and_safety_outlined),
  Option('زيارة طبيب منزلية', Icons.medical_services_outlined),
  Option('خدمات تحاليل منزلية', Icons.science_outlined),
  Option('إجراءات العلاج الطبيعي المنزلية', Icons.accessibility_new),
  Option('خدمات الأشعة المنزلية', Icons.document_scanner_outlined),
  Option('الرعاية والخدمات التمريضية المنزلية\nإقامة بالمنزل',
      Icons.volunteer_activism_outlined),
  Option('خدمات النقل الطبي الإسعافي\nللحالات غير الطارئة',
      Icons.airline_seat_flat_outlined),
  Option('الرعاية والخدمات التمريضية المنزلية\nالسريعة',
      Icons.volunteer_activism_outlined),
];

const areas = <Option>[
  Option('القاهرة'),
  Option('الجيزة'),
  Option('الإسكندرية'),
  Option('المنصورة'),
  Option('طنطا'),
];

const providers = <Option>[
  Option('أي مقدم خدمة متاح'),
  Option('فريق Doctorac الطبي'),
  Option('ممرض/ة معتمد'),
];

// ───────────────────────── Screen ─────────────────────────
class HomeCareScreen extends StatefulWidget {
  const HomeCareScreen({super.key});

  @override
  State<HomeCareScreen> createState() => _HomeCareScreenState();
}

class _HomeCareScreenState extends State<HomeCareScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  int? _service, _area, _provider;
  bool _submitted = false;
  String? _open; // which picker sheet is open: 'svc' | 'area' | 'prov'

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);
    final ok = _name.text.trim().isNotEmpty &&
        _phone.text.trim().isNotEmpty &&
        _service != null &&
        _area != null &&
        _provider != null;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: C.navy,
        content: Text(ok ? 'تم إرسال طلبك بنجاح' : 'أكمل البيانات المطلوبة',
            textAlign: TextAlign.center),
      ));
    // TODO: send the request to your backend when `ok` is true.
  }

  Widget _sheet() {
    final key = _open!;
    final title = key == 'svc'
        ? 'اختر الخدمة'
        : key == 'area'
        ? 'اختر المنطقة'
        : 'اختر مقدم الخدمة';
    final opts = key == 'svc' ? services : (key == 'area' ? areas : providers);
    final sel = key == 'svc' ? _service : (key == 'area' ? _area : _provider);
    return PickerSheet(
      title: title,
      options: opts,
      selected: sel,
      onClose: () => setState(() => _open = null),
      onSelect: (i) => setState(() {
        if (key == 'svc') {
          _service = i;
        } else if (key == 'area') {
          _area = i;
        } else {
          _provider = i;
        }
        _open = null;
      }),
    );
  }

  Widget _design() {
    return SizedBox.expand(
      child: Stack(
        children: [
          // soft blue wave at the bottom
          const Positioned(
            left: -75,
            right: -75,
            bottom: -40,
            height: 150,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xB3E6F0FB),
                borderRadius:
                BorderRadius.vertical(top: Radius.elliptical(263, 75)),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        const _TopBar(),
                        const _Banner(),
                        const SizedBox(height: 15),
                        _FormCard(
                          children: [
                            FieldShell(
                              icon: 'user',
                              label: 'الاسم الكامل',
                              error: _submitted && _name.text.trim().isEmpty,
                              child: _TextInput(
                                  controller: _name,
                                  hint: 'ادخل اسمك بالكامل',
                                  onChanged: (_) => setState(() {})),
                            ),
                            FieldShell(
                              icon: 'phone',
                              label: 'رقم الموبايل',
                              error: _submitted && _phone.text.trim().isEmpty,
                              child: _TextInput(
                                  controller: _phone,
                                  hint: 'ادخل رقم الهاتف',
                                  keyboard: TextInputType.phone,
                                  onChanged: (_) => setState(() {})),
                            ),
                            FieldShell(
                              icon: 'medical-clipboard',
                              label: 'الخدمة المطلوبة',
                              error: _submitted && _service == null,
                              onTap: () => setState(() => _open = 'svc'),
                              child: _Value(
                                  text: _service == null
                                      ? 'اختر الخدمة'
                                      : services[_service!]
                                      .label
                                      .replaceAll('\n', ' '),
                                  filled: _service != null),
                            ),
                            FieldShell(
                              icon: 'location-1',
                              label: 'المنطقة',
                              error: _submitted && _area == null,
                              onTap: () => setState(() => _open = 'area'),
                              child: _Value(
                                  text: _area == null
                                      ? 'اختر المنطقة'
                                      : areas[_area!].label,
                                  filled: _area != null),
                            ),
                            FieldShell(
                              icon: 'user',
                              label: 'مقدم الخدمة',
                              error: _submitted && _provider == null,
                              onTap: () => setState(() => _open = 'prov'),
                              child: _Value(
                                  text: _provider == null
                                      ? 'اختر مقدم الخدمة'
                                      : providers[_provider!].label,
                                  filled: _provider != null),
                            ),
                            _ConfirmButton(onPressed: _submit),
                          ],
                        ),
                        const _Footer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_open != null) ...[
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _open = null),
                child: const ColoredBox(color: Color(0x8C2D3A50)),
              ),
            ),
            Positioned(left: 0, right: 0, bottom: 0, top: 188, child: _sheet()),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F9FE), Color(0xFFF3F8FE), Color(0xFFEAF2FC)],
          ),
        ),
        child: SafeArea(
          child: _design(),
        ),
      ),
    );
  }
}

// ───────────────────────── Top bar ─────────────────────────
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.maybePop(context),
            child: SvgIcon.asset('assets/icons/arrow-left.svg',
                width: 20, height: 20, color: C.blue),
          ),
          const SizedBox(width: 10),
          const Text('احجز خدمة رعاية منزلية',
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w800, color: C.navy)),
        ],
      ),
    );
  }
}

// ───────────────────────── Banner ─────────────────────────
class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    const base = Color(0xFF0368BA);
    final bytes = _bannerBytes;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: base)),
            if (bytes != null)
              Positioned(
                right: 3,
                top: -49,
                width: 270,
                height: 270,
                child: Image.memory(
                  bytes,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            // soft fade so the left side blends with the photo
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 140,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [base, base.withValues(alpha: 0)],
                    stops: const [0.45, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -34,
              bottom: -56,
              child: Container(
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withValues(alpha: .3), width: 7),
                ),
              ),
            ),
            const Positioned(
              left: 22,
              top: 15,
              child: Text('Doctorac',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            Positioned(
              left: 22,
              top: 54,
              // LTR box so both lines are left-aligned like the design
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('احجز رعاية منزلية موثوقة',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('رعاية صحية آمنة ومريحة في منزلك',
                        style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: .92))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Form card ─────────────────────────
class _FormCard extends StatelessWidget {
  final List<Widget> children;
  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(11, 17, 11, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.border.withValues(alpha: .6)),
        boxShadow: [
          BoxShadow(
            color: C.navy.withValues(alpha: .06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

// ───────────────────────── Field shell ─────────────────────────
class FieldShell extends StatelessWidget {
  final String icon;
  final String label;
  final bool error;
  final VoidCallback? onTap;
  final Widget child;

  const FieldShell({
    super.key,
    required this.icon,
    required this.label,
    required this.child,
    this.error = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = error ? C.error : C.border;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgIcon.asset('assets/icons/$icon.svg',
                  width: 15, color: error ? C.error : C.icon),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: error ? C.error : C.ink)),
            ],
          ),
          const SizedBox(height: 5),
          Material(
            color: const Color(0xFFF9FBFE),
            borderRadius: BorderRadius.circular(11),
            child: InkWell(
              borderRadius: BorderRadius.circular(11),
              onTap: onTap,
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: borderColor, width: 1.2),
                ),
                child: Row(
                  children: [
                    Expanded(child: child),
                    if (onTap != null)
                      SvgIcon.asset('assets/icons/chevron-down.svg',
                          width: 20, color: C.mute),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboard;
  final ValueChanged<String>? onChanged;

  const _TextInput({
    required this.controller,
    required this.hint,
    this.keyboard,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      onChanged: onChanged,
      cursorColor: C.blue,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w600, color: C.ink),
      decoration: const InputDecoration.collapsed(
        hintText: '',
      ).copyWith(
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 12.5, fontWeight: FontWeight.w500, color: C.mute),
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String text;
  final bool filled;
  const _Value({required this.text, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: filled ? 13 : 12.5,
        fontWeight: filled ? FontWeight.w600 : FontWeight.w500,
        color: filled ? C.ink : C.mute,
      ),
    );
  }
}

// ───────────────────────── Confirm button ─────────────────────────
class _ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ConfirmButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: C.blue,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: onPressed,
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon.asset('assets/icons/calendar-check.svg',
                    width: 19, color: Colors.white),
                const SizedBox(width: 8),
                const Text('تأكيد الحجز',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Footer ─────────────────────────
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 13, color: C.mute),
          SizedBox(width: 5),
          Text('بياناتك محفوظة وآمنة معنا',
              style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: C.mute)),
        ],
      ),
    );
  }
}

// ───────────────────────── Picker sheet ─────────────────────────
class PickerSheet extends StatelessWidget {
  final String title;
  final List<Option> options;
  final int? selected;
  final VoidCallback onClose;
  final ValueChanged<int> onSelect;

  const PickerSheet({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onClose,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
                color: C.border, borderRadius: BorderRadius.circular(2)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 8, 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: C.navy)),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close, color: C.icon, size: 22),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: C.border),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 60),
              itemCount: options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, i) {
                final o = options[i];
                final isSel = selected == i;
                return Material(
                  color: isSel
                      ? C.blue.withValues(alpha: .08)
                      : const Color(0xFFF9FBFE),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onSelect(i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: isSel ? C.blue : C.border,
                            width: isSel ? 1.4 : 1),
                      ),
                      child: Row(
                        children: [
                          if (o.icon != null) ...[
                            Icon(o.icon, size: 20, color: C.icon),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            child: Text(o.label,
                                style: TextStyle(
                                    fontSize: 13,
                                    height: 1.35,
                                    fontWeight: isSel
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    color: C.ink)),
                          ),
                          if (isSel)
                            const Icon(Icons.check_circle,
                                size: 20, color: C.blue),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}