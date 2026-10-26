import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const HomeCareApp());
}

class HomeCareApp extends StatelessWidget {
  const HomeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFEFF5FE),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeCarePage(),
      ),
    );
  }
}

// ============================ الألوان ============================
class _C {
  static const primary = Color(0xFF1E73E8);
  static const navy = Color(0xFF0A2A6C);
  static const circle = Color(0xFFDCEBFC);
  static const soft = Color(0xFFE6F0FD);
  static const text = Color(0xFF14233F);
  static const grey = Color(0xFF8A94A6);
  static const line = Color(0xFFE3E9F2);
}

class HomeCareAssets {
  static const doctorVisit = 'assets/home-care-screen/images/home_doctor_visit_01.jpeg'; // صورة زيارة الطبيب
  static const nursingCare = 'assets/home-care-screen/images/home_care_service_01.jpeg'; // صورة الرعاية المنزلية
}

class HomeCarePage extends StatelessWidget {
  const HomeCarePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final cardInner = screenW - 36 - 28;
    final imgW = math.min(160.0, math.max(110.0, cardInner * 0.42));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE6F0FD), Color(0xFFF4F8FE)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
            children: [
              const _Header(),
              const SizedBox(height: 16),
              _DoctorCard(imgW: imgW),
              const SizedBox(height: 14),
              _NursingCard(imgW: imgW),
              const SizedBox(height: 24),
              const _Footer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

// ============================ الهيدر ============================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.maybePop(context),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.arrow_forward_rounded, color: _C.primary, size: 28),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الرعاية المنزلية',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _C.navy),
              ),
              SizedBox(height: 2),
              Text(
                'رعايتك في راحتك .. في بيتك',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, color: _C.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ======================= كارت زيارة طبيب =======================
class _DoctorCard extends StatelessWidget {
  const _DoctorCard({required this.imgW});
  final double imgW;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          // الصورة (يمين)
          _Blob(
            path: HomeCareAssets.doctorVisit,
            width: imgW,
            height: imgW * 1.15,
            mirror: false,
            badgeIcon: Icons.home_rounded,
            badgeAlignment: Alignment.topRight,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Pill(Icons.local_fire_department_rounded, 'الأكثر طلباً'),
                const SizedBox(height: 8),
                const Text(
                  'زيارة طبيب\nفي المنزل',
                  style: TextStyle(fontSize: 24, height: 1.25, fontWeight: FontWeight.w800, color: _C.navy),
                ),
                const SizedBox(height: 6),
                const Text(
                  'احصل على استشارة طبية من أفضل الأطباء في راحتك بدون الحاجة للخروج من منزلك.',
                  style: TextStyle(fontSize: 11.5, height: 1.5, color: _C.grey),
                ),
                const SizedBox(height: 12),
                const _FeaturesRow([
                  _Feature(Icons.shield_outlined, 'أطباء معتمدين'),
                  _Feature(Icons.access_time, 'مواعيد مرنة'),
                  _Feature(Icons.home_outlined, 'في جميع المناطق'),
                ]),
                const SizedBox(height: 14),
                _ActionButton(text: 'اطلب زيارة الطبيب', filled: true, onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NursingCard extends StatelessWidget {
  const _NursingCard({required this.imgW});
  final double imgW;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Pill(Icons.favorite_rounded, 'رعاية متكاملة'),
                const SizedBox(height: 8),
                const Text(
                  'خدمة رعاية منزلية',
                  style: TextStyle(fontSize: 20, height: 1.25, fontWeight: FontWeight.w800, color: _C.navy),
                ),
                const SizedBox(height: 6),
                const Text(
                  'ممرضين وممرضات متخصصين لتقديم الرعاية الصحية والتمريضية في منزلك.',
                  style: TextStyle(fontSize: 11.5, height: 1.5, color: _C.grey),
                ),
                const SizedBox(height: 12),
                const _FeaturesRow([
                  _Feature(Icons.health_and_safety_outlined, 'متابعة مستمرة'),
                  _Feature(Icons.favorite_border_rounded, 'رعاية يومية أو حسب الحاجة'),
                  _Feature(Icons.person_outline_rounded, 'طاقم مدرب ومؤهل'),
                ]),
                const SizedBox(height: 14),
                _ActionButton(text: 'اطلب خدمة الرعاية المنزلية', filled: false, onTap: () {}),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // الصورة (شمال)
          _Blob(
            path: HomeCareAssets.nursingCare,
            width: imgW,
            height: imgW * 1.15,
            mirror: true,
            badgeIcon: Icons.volunteer_activism_outlined,
            badgeAlignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}


class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFCFDDF2))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'صحتك وراحتك أولويتنا',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3B4A66)),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFCFDDF2))),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x121E73E8), blurRadius: 16, offset: Offset(0, 5)),
        ],
      ),
      child: child,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: _C.soft, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _C.primary, size: 13),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 10.5, color: _C.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Feature {
  const _Feature(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _FeaturesRow extends StatelessWidget {
  const _FeaturesRow(this.items);
  final List<_Feature> items;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      if (i > 0) {
        children.add(Container(width: 1, height: 34, color: _C.line));
      }
      children.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(items[i].icon, color: _C.primary, size: 20),
                const SizedBox(height: 4),
                Text(
                  items[i].label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, height: 1.25, color: _C.text),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.text, required this.filled, required this.onTap});
  final String text;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = filled ? Colors.white : _C.primary;
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: Material(
        color: filled ? _C.primary : Colors.white,
        shape: StadiumBorder(
          side: filled ? BorderSide.none : const BorderSide(color: _C.primary, width: 1.2),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Center(
            // لو النص أكبر من المساحة بيصغر لوحده
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(text, style: TextStyle(color: fg, fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: fg, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.path,
    required this.width,
    required this.height,
    required this.mirror,
    required this.badgeIcon,
    required this.badgeAlignment,
  });

  final String path;
  final double width;
  final double height;
  final bool mirror;
  final IconData badgeIcon;
  final Alignment badgeAlignment;

  @override
  Widget build(BuildContext context) {
    final big = Radius.circular(width * 0.45);
    final small = Radius.circular(width * 0.28);
    final mid = Radius.circular(width * 0.30);
    final big2 = Radius.circular(width * 0.48);

    final radius = mirror
        ? BorderRadius.only(topLeft: small, topRight: big, bottomLeft: big2, bottomRight: mid)
        : BorderRadius.only(topLeft: big, topRight: small, bottomLeft: mid, bottomRight: big2);

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // الهالة
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: _C.circle, borderRadius: radius),
            ),
          ),
          // الصورة
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: radius,
                child: _Img(path, fit: BoxFit.cover),
              ),
            ),
          ),
          // الأيقونة الدايرية
          Positioned.fill(
            child: Align(
              alignment: badgeAlignment,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Color(0x261E73E8), blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Icon(badgeIcon, color: _C.primary, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Img extends StatelessWidget {
  const _Img(this.path, {this.width, this.height, this.fit = BoxFit.cover});
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: const Color(0xFFDCE9FA),
          alignment: Alignment.center,
          child: const Icon(Icons.image_outlined, color: Color(0xFF8DB4E8), size: 22),
        );
      },
    );
  }
}

// ======================= الشريط اللي تحت =======================
class _NavItem {
  const _NavItem(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  static const _items = [
    _NavItem(Icons.home_rounded, 'الرئيسية'),
    _NavItem(Icons.calendar_month_outlined, 'مواعيدي'),
    _NavItem(Icons.account_balance_wallet_outlined, 'محفظتي'),
    _NavItem(Icons.account_circle_outlined, 'حسابي'),
  ];

  @override
  Widget build(BuildContext context) {
    const selected = 0; // الرئيسية متفعلة
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: bottomInset > 0 ? bottomInset : 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [
          BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, -4)),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_items[i].icon, size: 28, color: i == selected ? _C.primary : _C.grey),
                  const SizedBox(height: 3),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _items[i].label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: i == selected ? FontWeight.w800 : FontWeight.w500,
                        color: i == selected ? _C.primary : _C.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 34,
                    height: 3,
                    decoration: BoxDecoration(
                      color: i == selected ? _C.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}