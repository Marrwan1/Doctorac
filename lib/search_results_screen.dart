import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/custom_bottom_nav_bar.dart';

const _img = 'assets/search-results-screen/images/';
const _ico = 'assets/search-results-screen/icons/';
const _primary = Color(0xFF0875E1);
const _darkBlue = Color(0xFF0B5FD8);
const _dark = Color(0xFF10264F);
const _grey = Color(0xFF718096);
const _bg = Color(0xFFF4F9FF);

Widget _svg(String name, {double size = 20, Color? color}) => SvgPicture.asset(
  '$_ico$name',
  width: size,
  height: size,
  colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
);

class SearchDoctor {
  final String title,
      name,
      specialty,
      fullTitle,
      area,
      city,
      center,
      centerType,
      clinic,
      image;
  final double rating;
  final int reviews, price, wait;

  const SearchDoctor({
    required this.title,
    required this.name,
    required this.specialty,
    required this.fullTitle,
    required this.area,
    required this.city,
    required this.center,
    required this.centerType,
    required this.clinic,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.wait,
    required this.image,
  });
}

// بيانات تجريبية (أسماء وهمية)
// بيانات تجريبية (أسماء وهمية)
const _doctors = [
  SearchDoctor(
    title: 'دكتور',
    name: 'أحمد مصطفى',
    specialty: 'باطنة',
    fullTitle: 'أخصائي الباطنة العامة',
    area: 'مدينة نصر',
    city: 'القاهرة',
    center: 'مركز الأمل الطبي',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات الأمل',
    rating: 4.9,
    reviews: 320,
    price: 250,
    wait: 15,
    image: 'doctor_01.png',
  ),
  SearchDoctor(
    title: 'دكتورة',
    name: 'سارة علي',
    specialty: 'جلدية',
    fullTitle: 'أخصائي الأمراض الجلدية والتجميل',
    area: 'الشيخ زايد',
    city: 'الجيزة',
    center: 'مركز النيل الطبي',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات النيل',
    rating: 4.8,
    reviews: 245,
    price: 300,
    wait: 10,
    image: 'doctor_02.png',
  ),
  SearchDoctor(
    title: 'دكتور',
    name: 'محمد عبد الله',
    specialty: 'قلب',
    fullTitle: 'أخصائي القلب والضغط',
    area: 'المعادي',
    city: 'القاهرة',
    center: 'مستشفى المعادي',
    centerType: 'مستشفى',
    clinic: 'عيادات القلب',
    rating: 4.7,
    reviews: 190,
    price: 280,
    wait: 20,
    image: 'doctor_03.png',
  ),
  SearchDoctor(
    title: 'دكتورة',
    name: 'منى حسن',
    specialty: 'أطفال',
    fullTitle: 'أخصائي طب الأطفال',
    area: 'الزمالك',
    city: 'القاهرة',
    center: 'مركز الطفل السعيد',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات الطفل',
    rating: 4.9,
    reviews: 410,
    price: 260,
    wait: 10,
    image: 'doctor_00.jpeg',
  ),
  SearchDoctor(
    title: 'دكتور',
    name: 'كريم شحاتة',
    specialty: 'أنف وأذن وحنجرة',
    fullTitle: 'أخصائي الأنف والأذن والحنجرة',
    area: 'الشيخ زايد',
    city: 'الجيزة',
    center: 'مركز السمع',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات السمع',
    rating: 4.7,
    reviews: 190,
    price: 270,
    wait: 12,
    image: 'doctor_04.png',
  ),
  SearchDoctor(
    title: 'دكتورة',
    name: 'نهى ناجي',
    specialty: 'جلدية',
    fullTitle: 'استشاري الأمراض الجلدية والتناسلية',
    area: 'مدينة نصر',
    city: 'القاهرة',
    center: 'مركز دار الشفاء الطبي',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات كير بلس',
    rating: 4.9,
    reviews: 1837,
    price: 600,
    wait: 10,
    image: 'doctor_00.jpeg',
  ),
  SearchDoctor(
    title: 'دكتور',
    name: 'عمر فتحي',
    specialty: 'أسنان',
    fullTitle: 'استشاري طب الأسنان',
    area: 'التجمع الخامس',
    city: 'القاهرة',
    center: 'مركز الابتسامة',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات الابتسامة',
    rating: 4.6,
    reviews: 150,
    price: 350,
    wait: 15,
    image: 'doctor_05.png',
  ),
  SearchDoctor(
    title: 'دكتورة',
    name: 'ياسمين خالد',
    specialty: 'نفسي',
    fullTitle: 'استشاري الطب النفسي',
    area: 'الدقي',
    city: 'الجيزة',
    center: 'مركز راحة',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات راحة',
    rating: 4.8,
    reviews: 210,
    price: 500,
    wait: 20,
    image: 'doctor_02.png',
  ),
  SearchDoctor(
    title: 'دكتور',
    name: 'طارق سمير',
    specialty: 'مخ وأعصاب',
    fullTitle: 'استشاري المخ والأعصاب',
    area: 'مصر الجديدة',
    city: 'القاهرة',
    center: 'مركز الأعصاب',
    centerType: 'مستشفى',
    clinic: 'عيادات الأعصاب',
    rating: 4.7,
    reviews: 175,
    price: 450,
    wait: 25,
    image: 'doctor_01.png',
  ),
  SearchDoctor(
    title: 'دكتورة',
    name: 'هبة إبراهيم',
    specialty: 'نساء وتوليد',
    fullTitle: 'استشاري النساء والتوليد',
    area: 'المهندسين',
    city: 'الجيزة',
    center: 'مركز الأمومة',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات الأمومة',
    rating: 4.9,
    reviews: 520,
    price: 400,
    wait: 15,
    image: 'doctor_00.jpeg',
  ),
  SearchDoctor(
    title: 'دكتور',
    name: 'أمير سعيد',
    specialty: 'عظام',
    fullTitle: 'أخصائي جراحة العظام',
    area: '6 أكتوبر',
    city: 'الجيزة',
    center: 'مركز العظام',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات العظام',
    rating: 4.6,
    reviews: 130,
    price: 320,
    wait: 10,
    image: 'doctor_03.png',
  ),
  SearchDoctor(
    title: 'دكتورة',
    name: 'دينا عادل',
    specialty: 'أسنان',
    fullTitle: 'أخصائي تقويم الأسنان',
    area: 'الشيخ زايد',
    city: 'الجيزة',
    center: 'مركز دنتال كير',
    centerType: 'عيادة خاصة',
    clinic: 'عيادات دنتال كير',
    rating: 4.8,
    reviews: 260,
    price: 300,
    wait: 10,
    image: 'doctor_02.png',
  ),
];

class SearchResultsScreen extends StatefulWidget {
  final String specialty;
  const SearchResultsScreen({super.key, required this.specialty});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String _query = '';
  bool _sortByPrice = false;
  bool _network = true;

  @override
  Widget build(BuildContext context) {
    var results = _doctors.where((d) => d.specialty == widget.specialty);
    if (_query.isNotEmpty) {
      results = results.where(
        (d) =>
            d.name.contains(_query) ||
            d.center.contains(_query) ||
            d.area.contains(_query),
      );
    }
    final list = results.toList();
    if (_sortByPrice) {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _bg,
        bottomNavigationBar: CustomBottomNavBar(currentIndex: 0, onTap: (_) {}),
        body: Column(
          children: [
            _header(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _chipsRow(),
                  const SizedBox(height: 12),
                  _networkToggle(),
                  const SizedBox(height: 14),
                  if (list.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(
                        child: Text(
                          'مفيش دكاترة مطابقين للبحث',
                          style: TextStyle(fontSize: 15, color: _dark),
                        ),
                      ),
                    ),
                  for (final d in list) ...[
                    _DoctorCard(doctor: d),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(
      16,
      MediaQuery.of(context).padding.top + 12,
      16,
      20,
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0875E1), Color(0xFF3FA2FF)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(child: _svg('chevron-right.svg', size: 20)),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'ابحث عن دكتور',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'دكاترة ${widget.specialty}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFDCEBFF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              _svg('search.svg', size: 20, color: _primary),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _query = v.trim()),
                  decoration: const InputDecoration(
                    hintText: 'ابحث باسم الدكتور أو المستشفى...',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              _svg('slider-settings.svg', size: 20, color: _primary),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _chipsRow() => Row(
    children: [
      _chip(
        'arrange-ascending-alphabetic.svg',
        _sortByPrice ? 'الأقل سعراً' : 'الترتيب',
        () => setState(() => _sortByPrice = !_sortByPrice),
      ),
      const SizedBox(width: 8),
      _chip('filter.svg', 'التصفية', () => _soon('التصفية')),
      const SizedBox(width: 8),
      _chip('map-2.svg', 'الخريطة', () => _soon('الخريطة')),
    ],
  );

  void _soon(String what) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$what قريباً')));

  Widget _chip(String icon, String text, VoidCallback onTap) => Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE0ECFA)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _svg(icon, size: 18, color: _primary),
            const SizedBox(width: 6),
            Text(text, style: const TextStyle(fontSize: 13, color: _dark)),
          ],
        ),
      ),
    ),
  );

  Widget _networkToggle() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFE6F1FF),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        const Text(
          'S',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: _dark,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عرض شبكة شامل',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),
              Text(
                'لنتائج أدق وتجربة أفضل',
                style: TextStyle(fontSize: 11, color: _grey),
              ),
            ],
          ),
        ),
        Switch(
          value: _network,
          activeColor: Colors.white,
          activeTrackColor: _primary,
          onChanged: (v) => setState(() => _network = v),
        ),
      ],
    ),
  );
}

class _DoctorCard extends StatefulWidget {
  final SearchDoctor doctor;
  const _DoctorCard({required this.doctor});

  @override
  State<_DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<_DoctorCard> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.doctor;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0875E1),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _top(d),
          const SizedBox(height: 12),
          _infoRow(d),
          const SizedBox(height: 12),
          _onlineBanner(),
          const SizedBox(height: 12),
          _buttons(d),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE6EEF8)),
          const SizedBox(height: 10),
          _footer(d),
        ],
      ),
    );
  }

  Widget _top(SearchDoctor d) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD6E8FF), width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                '$_img${d.image}',
                width: 74,
                height: 74,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: 74,
                  height: 74,
                  child: Icon(Icons.person, color: _primary),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            left: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: _svg('badge-check.svg', size: 22, color: _primary),
            ),
          ),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(d.title, style: const TextStyle(fontSize: 12, color: _grey)),
            Text(
              d.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _dark,
              ),
            ),
            Text(
              d.fullTitle,
              style: const TextStyle(fontSize: 12.5, color: _dark),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                for (var i = 0; i < 5; i++)
                  _svg('star.svg', size: 15, color: const Color(0xFFFFB400)),
                const SizedBox(width: 6),
                Text(
                  '(${d.rating})',
                  style: const TextStyle(fontSize: 12, color: _grey),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'التقييم العام من ${d.reviews} زائر',
              style: const TextStyle(fontSize: 11.5, color: _grey),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F8FD),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _svg('phone.svg', size: 14, color: _dark),
                  const SizedBox(width: 6),
                  const Text(
                    'مستمع جديد',
                    style: TextStyle(fontSize: 12, color: _dark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F6EC),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _svg('check-circle.svg', size: 14, color: const Color(0xFF1FA35A)),
            const SizedBox(width: 4),
            const Text(
              'متاح للحجز',
              style: TextStyle(fontSize: 11, color: Color(0xFF1FA35A)),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _infoRow(SearchDoctor d) => Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    decoration: BoxDecoration(
      color: const Color(0xFFF7FAFE),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cell('location-1.svg', d.area, d.city),
        _cell('office-building.svg', d.center, d.centerType),
        _cell('dollar-bill.svg', 'سعر الكشف:', '${d.price} جنية', bold: true),
        _cell('clock.svg', 'مدة الانتظار:', '${d.wait} دقيقة', green: true),
      ],
    ),
  );

  Widget _cell(
    String icon,
    String top,
    String bottom, {
    bool bold = false,
    bool green = false,
  }) => Expanded(
    child: Column(
      children: [
        _svg(icon, size: 20, color: _primary),
        const SizedBox(height: 6),
        Text(
          top,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10.5, color: _dark),
        ),
        const SizedBox(height: 2),
        Text(
          bottom,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: bold || green ? FontWeight.bold : null,
            color: green ? const Color(0xFF1FA35A) : (bold ? _dark : _grey),
          ),
        ),
      ],
    ),
  );

  Widget _onlineBanner() => Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF3FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: _primary,
              size: 22,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'متوفر حجز أون/لاين',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _primary,
                ),
              ),
            ),
            _svg('chevron-left.svg', size: 18, color: _primary),
          ],
        ),
      ),
      Positioned(
        top: -9,
        right: 12,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'جديدة',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
      ),
    ],
  );

  Widget _buttons(SearchDoctor d) => Row(
    children: [
      Expanded(
        flex: 3,
        child: SizedBox(
          height: 46,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _darkBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
            ),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم اختيار ${d.title} ${d.name}')),
            ),
            icon: const Icon(Icons.calendar_month_outlined, size: 20),
            label: const Text('احجز الآن'),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 2,
        child: SizedBox(
          height: 46,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: _dark,
              side: const BorderSide(color: Color(0xFFE0ECFA)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
            ),
            onPressed: () => setState(() => _fav = !_fav),
            icon: Icon(
              _fav ? Icons.favorite : Icons.favorite_border,
              size: 20,
              color: _fav ? Colors.red : _dark,
            ),
            label: const Text('المفضلة', style: TextStyle(fontSize: 12.5)),
          ),
        ),
      ),
    ],
  );

  Widget _footer(SearchDoctor d) => Row(
    children: [
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            const Text(
              'عرض المزيد من التفاصيل',
              style: TextStyle(fontSize: 11.5, color: _primary),
            ),
            const SizedBox(width: 2),
            _svg('chevron-left.svg', size: 16, color: _primary),
          ],
        ),
      ),
      const Spacer(),
      Text(d.clinic, style: const TextStyle(fontSize: 12, color: _grey)),
      const SizedBox(width: 6),
      Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Color(0xFFFFE8F0),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.favorite, size: 13, color: Color(0xFFE0457B)),
      ),
    ],
  );
}
