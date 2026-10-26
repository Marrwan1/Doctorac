import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const DoctoracApp());

class AppAssets {

  static const logo = 'assets/logo/logo_text1.png';


  static const clinic = 'assets/home-screen/images/H.svg'; // كشف عيادة
  static const pharmacy = 'assets/home-screen/images/pharmacy.png'; // صيدلية
  static const callDoctor = 'assets/home-screen/images/talk_to_doctor.png'; // مكالمة دكتور
  static const homeCare = 'assets/home-screen/images/home_care.png'; // رعاية منزلية
  static const procedure = 'assets/home-screen/images/medical_procedures.png'; // خدمة أو عملية
  static const labs = 'assets/home-screen/images/labs_and_radiology.png'; // أشعة و تحاليل


  static const bannerDoctor = 'assets/home-screen/images/Booking_a_clinic_appointment.jpeg';


  static const doctors = [
    'assets/home-screen/images/doctor_03.png',
    'assets/home-screen/images/doctor_02.png',
    'assets/home-screen/images/doctor_01.png',
    'assets/home-screen/images/doctor_06.jpg',
  ];
}


class CenterData {
  final String name;
  final String specialties; // عدد التخصصات
  final String area; // المناطق
  final List<String> tags;
  final String logo; // مسار اللوجو
  final String photo; // مسار صورة المركز
  const CenterData({
    required this.name,
    required this.specialties,
    required this.area,
    required this.tags,
    required this.logo,
    required this.photo,
  });
}

class AppImage extends StatelessWidget {
  final String path;
  final double? width, height;
  final BoxFit fit;
  final double radius;
  final Alignment alignment;
  const AppImage(this.path,
      {super.key,
        this.width,
        this.height,
        this.fit = BoxFit.cover,
        this.radius = 0,
        this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    if (path.toLowerCase().endsWith('.svg')) {
      final placeholder = Container(
        width: width,
        height: height,
        color: const Color(0xFFDCE9FA),
        alignment: Alignment.center,
        child: const Icon(Icons.image_outlined, color: Color(0xFF8DB4E8), size: 22),
      );
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SvgPicture.asset(
          path,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          placeholderBuilder: (_) => placeholder,
          errorBuilder: (_, __, ___) => placeholder,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: const Color(0xFFDCE9FA),
          alignment: Alignment.center,
          child: const Icon(Icons.image_outlined, color: Color(0xFF8DB4E8), size: 22),
        ),
      ),
    );
  }
}

class C {
  static const primary = Color(0xFF1E73E8);
  static const navy = Color(0xFF0A2A6C);
  static const bg = Color(0xFFEFF5FE);
  static const circle = Color(0xFFDCEBFC);
  static const text = Color(0xFF14233F);
  static const grey = Color(0xFF8A94A6);
}

class DoctoracApp extends StatelessWidget {
  const DoctoracApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: (c, child) {
        final mq = MediaQuery.of(c);
        final scaler = mq.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.15);
        return MediaQuery(
          data: mq.copyWith(textScaler: scaler),
          child: Directionality(textDirection: TextDirection.rtl, child: child!),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: C.bg,
      ),
      home: const HomePage(),
    );
  }
}

BoxDecoration cardDeco({double r = 20}) => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(r),
  boxShadow: [
    BoxShadow(color: const Color(0xFF1E73E8).withOpacity(.07), blurRadius: 16, offset: const Offset(0, 5)),
  ],
);

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;

  static const List<CenterData> _centersData = [
    CenterData(
      name: 'مصر الحديثة',
      specialties: '7V تخصص',
      area: 'الدهي، والمهندسين... الخ',
      tags: ['عيادات تخصصية', 'أجهزة حديثة', 'طاقم متميز'],
      logo: 'assets/home-screen/images/clinic-logo.jpeg',
      photo: 'assets/home-screen/images/clinic_03.png',
    ),
    CenterData(
      name: 'مركز النيل التخصصي',
      specialties: '12 تخصص',
      area: 'المعادي، دار السلام',
      tags: ['استقبال 24 ساعة', 'معامل تحاليل', 'أشعة متقدمة'],
      logo: 'assets/home-screen/images/l4.png',
      photo: 'assets/home-screen/images/clinic_02.png',
    ),
    CenterData(
      name: 'مركز الشروق الطبي',
      specialties: '9 تخصصات',
      area: 'مدينة نصر، مصر الجديدة',
      tags: ['أطباء استشاريين', 'حجز سريع', 'أسعار مناسبة'],
      logo: 'assets/home-screen/images/l3.png',
      photo: 'assets/home-screen/images/clinic_01.png',
    ),
    CenterData(
      name: 'مركز الأمل للرعاية',
      specialties: '8 تخصصات',
      area: 'وسط البلد، الزمالك',
      tags: ['رعاية متكاملة', 'عيادات أطفال', 'خدمة منزلية'],
      logo: 'assets/home-screen/images/l2.png',
      photo: 'assets/home-screen/images/1.png',
    ),
    CenterData(
      name: 'مركز التجمع الطبي',
      specialties: '15 تخصص',
      area: 'التجمع الخامس، الرحاب',
      tags: ['أحدث الأجهزة', 'غرف عمليات', 'مواقف سيارات'],
      logo: 'assets/home-screen/images/l1.png',
      photo: 'assets/home-screen/images/02.jpg',
    ),
  ];

  int get _centersCount => _centersData.length;
  static const double _centerGap = 12;
  final ScrollController _centersCtrl = ScrollController();
  final ValueNotifier<double> _centerProgress = ValueNotifier<double>(0);
  double _centerCardW = 330;

  @override
  void initState() {
    super.initState();
    _centersCtrl.addListener(() {
      if (!_centersCtrl.hasClients) return;
      final pos = _centersCtrl.position;
      if (!pos.hasContentDimensions) return;
      final max = pos.maxScrollExtent;
      final p = max <= 0 ? 0.0 : (pos.pixels / max).clamp(0.0, 1.0);
      _centerProgress.value = p * (_centersCount - 1);
    });
  }

  @override
  void dispose() {
    _centersCtrl.dispose();
    _centerProgress.dispose();
    super.dispose();
  }

  double get _ts => MediaQuery.textScalerOf(context).scale(1);

  @override
  Widget build(BuildContext context) {
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
          child: IndexedStack(
            index: tab,
            children: [
              _homeTab(),
              _placeholder(Icons.calendar_month_outlined, 'مواعيدي'),
              _placeholder(Icons.account_balance_wallet_outlined, 'محفظتي'),
              _placeholder(Icons.account_circle_outlined, 'حسابي'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _homeTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
      children: [
        _header(),
        const SizedBox(height: 18),
        _search(),
        const SizedBox(height: 18),
        _services(),
        const SizedBox(height: 18),
        _banner(),
        const SizedBox(height: 20),
        _sectionTitle('أطباء موثوقين'),
        const SizedBox(height: 12),
        _doctors(),
        const SizedBox(height: 20),
        _sectionTitle('المراكز الأقرب لك'),
        const SizedBox(height: 12),
        _centers(),
        const SizedBox(height: 10),
        _dots(),
      ],
    );
  }

  Widget _placeholder(IconData icon, String title) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(color: C.circle, shape: BoxShape.circle),
            child: Icon(icon, color: C.primary, size: 38),
          ),
          const SizedBox(height: 14),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: C.text)),
          const SizedBox(height: 4),
          const Text('قريباً', style: TextStyle(fontSize: 13, color: C.grey)),
        ],
      ),
    );
  }

  // ---------------- Header ----------------
  Widget _header() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // اللوجو
                const Flexible(
                  child: AppImage(
                    AppAssets.logo,
                    width: 150,
                    height: 40,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                const SizedBox(width: 12),
                // الأيقونات
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 34,
                      height: 48,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.notifications_none_rounded, color: C.primary, size: 28),
                          Positioned(
                            right: 3,
                            top: 11,
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: const BoxDecoration(color: C.primary, shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(color: C.circle, shape: BoxShape.circle),
                      child: const Icon(Icons.person, color: C.primary, size: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          const Text('رعايتك الصحية .. أسهل',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: C.grey, fontSize: 13)),
        ],
      ),
    );
  }

  // ---------------- Search ----------------
  Widget _search() {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: cardDeco(r: 18),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            const Icon(Icons.search, color: C.primary, size: 24),
            const SizedBox(width: 14),
            const Expanded(
              child: Text('ابحث بالتخصص، اسم الدكتور، أو المستشفى',
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: C.grey, fontSize: 13)),
            ),
            Container(width: 1, height: 24, color: const Color(0xFFE3E9F2), margin: const EdgeInsets.symmetric(horizontal: 12)),
            const Icon(Icons.tune_rounded, color: C.primary, size: 24),
          ],
        ),
      ),
    );
  }

  // ---------------- Services grid ----------------
  Widget _services() {
    final items = [
      ('كشف عيادة', AppAssets.clinic),
      ('صيدلية', AppAssets.pharmacy),
      ('مكالمة دكتور', AppAssets.callDoctor),
      ('رعاية منزلية', AppAssets.homeCare),
      ('خدمة أو عملية', AppAssets.procedure),
      ('أشعة و تحاليل', AppAssets.labs),
    ];
    return LayoutBuilder(builder: (context, c) {
      const gap = 12.0;
      final cellW = (c.maxWidth - gap * 2) / 3;
      // الدايرة بتصغر على الشاشات الصغيرة وأقصاها 84
      final circle = (cellW - 12).clamp(60.0, 84.0);
      // ارتفاع الكارت بيتحسب من محتواه الفعلي
      final cellH = 14 + circle + 10 + 20 * _ts + 8 + 28 + 10 + 4;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: gap,
          crossAxisSpacing: gap,
          mainAxisExtent: cellH,
        ),
        itemBuilder: (_, i) => _serviceCard(items[i].$1, items[i].$2, circle),
      );
    });
  }

  Widget _serviceCard(String title, String img, double circle) {
    return Container(
      decoration: cardDeco(),
      padding: const EdgeInsets.fromLTRB(6, 14, 6, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: circle,
            height: circle,
            decoration: const BoxDecoration(color: C.circle, shape: BoxShape.circle),
            child: ClipOval(child: AppImage(img, width: circle, height: circle)),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(title,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: C.text)),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(color: Color(0xFFE6F0FD), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward_rounded, color: C.primary, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return LayoutBuilder(builder: (context, c) {
      final imgW = (c.maxWidth * 0.45).clamp(120.0, 170.0);
      return Container(
        height: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(colors: [Color(0xFFE3EEFC), Color(0xFFF1F6FE)]),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: imgW,
              child: const AppImage(AppAssets.bannerDoctor, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 12, 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('احجز كشف عيادة',
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: C.navy)),
                        const Text('في لا خطوات بسيطة', style: TextStyle(color: C.grey, fontSize: 13)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _feature(Icons.shield_outlined, 'أطباء معتمدين'),
                            _vDivider(),
                            _feature(Icons.access_time, 'مواعيد مرنة'),
                            _vDivider(),
                            _feature(Icons.verified_user_outlined, 'أمان وخصوصية'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(color: C.primary, borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                              SizedBox(width: 10),
                              Text('ابدأ الآن',
                                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _feature(IconData i, String t) => Column(
    children: [
      Icon(i, color: C.primary, size: 17),
      const SizedBox(height: 2),
      Text(t, style: const TextStyle(fontSize: 9.5, color: C.text)),
    ],
  );

  Widget _vDivider() => Container(
      width: 1, height: 28, margin: const EdgeInsets.symmetric(horizontal: 9), color: const Color(0xFFCFDDF2));

  // ---------------- Section title ----------------
  Widget _sectionTitle(String t) {
    return Row(
      children: [
        Expanded(
          child: Text(t,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: C.text)),
        ),
        const Text('عرض الكل', style: TextStyle(color: C.primary, fontSize: 14)),
        const SizedBox(width: 6),
        const Icon(Icons.arrow_back_rounded, color: C.primary, size: 18),
      ],
    );
  }

  // ---------------- Doctors ----------------
  Widget _doctors() {
    final docs = [
      ('د. أحمد مصطفى', 'أخصائي باطنية عامة', 'مدينة نصر', '4.9', '250'),
      ('د. سارة علي', 'أخصائي جلدية وتجميل', 'الشيخ زايد', '4.8', '300'),
      ('د. محمد عبد الله', 'أخصائي قلب وضغط', 'المعادي', '4.7', '280'),
      ('د. مني حسن', 'أخصائي أطفال', 'الزمالك', '4.9', '260'),
    ];
    return SizedBox(
      height: 235 + (_ts - 1) * 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: docs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final d = docs[i];
          return Container(
            width: 190,
            padding: const EdgeInsets.all(10),
            decoration: cardDeco(r: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // مكان صورة الدكتور
                Stack(
                  children: [
                    AppImage(AppAssets.doctors[i], width: double.infinity, height: 92, radius: 12),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(d.$4, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                            const SizedBox(width: 3),
                            const Icon(Icons.star_rounded, color: Color(0xFFF5A623), size: 14),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(Icons.favorite_border_rounded, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(d.$1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: C.text)),
                const SizedBox(height: 2),
                Text(d.$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: C.grey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: C.primary, size: 14),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(d.$3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: C.grey)),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text('${d.$5} ج.م', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(color: const Color(0xFFE6F0FD), borderRadius: BorderRadius.circular(14)),
                      child: const Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, color: C.primary, size: 15),
                          SizedBox(width: 5),
                          Text('احجز', style: TextStyle(color: C.primary, fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _centers() {
    final screenW = MediaQuery.of(context).size.width;
    // عرض الكارت بيتناسب مع الشاشة وفيه جزء ظاهر من الكارت اللي بعده
    _centerCardW = (screenW * 0.9).clamp(320.0, 380.0);
    final imgSize = _centerCardW < 340 ? 84.0 : 100.0;

    return SizedBox(
      height: 156 + (_ts - 1) * 80,
      child: ListView.separated(
        controller: _centersCtrl,
        physics: _SnapScrollPhysics(
            itemExtent: _centerCardW + _centerGap, parent: const ClampingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: _centersCount,
        separatorBuilder: (_, __) => const SizedBox(width: _centerGap),
        itemBuilder: (_, i) => _centerCard(_centersData[i], _centerCardW, imgSize),
      ),
    );
  }

  Widget _centerCard(CenterData d, double width, double imgSize) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: cardDeco(r: 18),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE3E9F2)),
            ),
            child: ClipOval(child: AppImage(d.logo, width: 62, height: 62, fit: BoxFit.contain)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: C.text)),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.medical_services_outlined, color: C.primary, size: 13),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(d.specialties,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: C.grey)),
                      ),
                    ]),
                    const SizedBox(height: 3),
                    Row(children: [
                      const Icon(Icons.apartment_rounded, color: C.primary, size: 13),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(d.area,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: C.grey)),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: d.tags
                          .map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEAF2FD), borderRadius: BorderRadius.circular(8)),
                        child: Text(t, style: const TextStyle(fontSize: 9, color: C.primary)),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // صورة المركز
          AppImage(d.photo, width: imgSize, height: imgSize, radius: 12),
          const SizedBox(width: 8),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(color: Color(0xFFE6F0FD), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back_rounded, color: C.primary, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _dots() {
    return ValueListenableBuilder<double>(
      valueListenable: _centerProgress,
      builder: (_, active, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_centersCount, (i) {
          final t = (1 - (i - active).abs()).clamp(0.0, 1.0);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 7 + 9 * t,
            height: 7,
            decoration: BoxDecoration(
              color: Color.lerp(const Color(0xFFCFDDF2), C.primary, t),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  // ---------------- Bottom nav ----------------
  Widget _bottomNav() {
    final items = [
      (Icons.home_rounded, 'الرئيسية'),
      (Icons.calendar_month_outlined, 'مواعيدي'),
      (Icons.account_balance_wallet_outlined, 'محفظتي'),
      (Icons.account_circle_outlined, 'حسابي'),
    ];
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: bottomInset > 0 ? bottomInset : 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, -4))],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final sel = tab == i;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => tab = i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(items[i].$1, size: 28, color: sel ? C.primary : C.grey),
                  const SizedBox(height: 3),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(items[i].$2,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                            color: sel ? C.primary : C.grey)),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 34,
                    height: 3,
                    decoration: BoxDecoration(
                        color: sel ? C.primary : Colors.transparent, borderRadius: BorderRadius.circular(2)),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SnapScrollPhysics extends ScrollPhysics {
  final double itemExtent;
  const _SnapScrollPhysics({required this.itemExtent, super.parent});

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SnapScrollPhysics(itemExtent: itemExtent, parent: buildParent(ancestor));

  double _target(ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = position.pixels / itemExtent;
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    final t = page.roundToDouble() * itemExtent;
    return t.clamp(position.minScrollExtent, position.maxScrollExtent);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = toleranceFor(position);
    final target = _target(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}