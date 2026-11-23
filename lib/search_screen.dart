import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _primary = Color(0xFF0875E1);
  static const _dark = Color(0xFF10264F);
  static const _bg = Color(0xFFF4F9FF);
  static const _icons = 'assets/search-screen/icons/';

  static const _specialties = [
    ('جلدية', 'dermatology.svg'),
    ('أسنان', 'tooth.svg'),
    ('نفسي', 'psychology.svg'),
    ('أطفال', 'pediatrics.svg'),
    ('مخ وأعصاب', 'neurology.svg'),
    ('عظام', 'orthopedics.svg'),
    ('نساء وتوليد', 'obstetrics.svg'),
    ('أنف وأذن وحنجرة', 'ear-nose-and-throat.svg'),
    ('قلب', 'cardiology.svg'),
    ('باطنة', 'internal-medicine.svg'),
  ];

  final TextEditingController _controller = TextEditingController();
  String _query = '';

  String _normalizeArabic(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي');
  }

  String get _normalizedQuery => _normalizeArabic(_query);

  List<SearchDoctor> get _matchingDoctors {
    if (_normalizedQuery.isEmpty) return [];

    return searchDoctors.where((doctor) {
      // البحث هنا عن الدكاترة فقط، وليس عن التخصصات.
      // تضمين اللقب يجعل البحث بكلمة "دكتور" أو "دكتورة" يعرض النتائج.
      final searchable = _normalizeArabic(
        '${doctor.title} ${doctor.name} ${doctor.center} '
        '${doctor.area} ${doctor.city} ${doctor.clinic}',
      );
      return searchable.contains(_normalizedQuery);
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openResults({String specialty = 'الكل', String query = ''}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SearchResultsScreen(specialty: specialty, initialQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searching = _normalizedQuery.isNotEmpty;
    final doctors = _matchingDoctors;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _bg,
        body: Column(
          children: [
            _header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                children: [
                  Text(
                    searching ? 'نتائج البحث' : 'اختار التخصص',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (searching) ...[
                    const Text(
                      'الدكاترة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (doctors.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'مفيش دكاترة مطابقين. جرّب اسم الدكتور أو المنطقة.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    for (final doctor in doctors) _doctorSuggestion(doctor),
                  ],

                  if (!searching)
                    for (final specialty in _specialties)
                      _specialtyRow(specialty),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(
      20,
      MediaQuery.of(context).padding.top + 14,
      20,
      24,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.maybePop(context),
          child: SvgPicture.asset(
            '${_icons}arrow-right.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'ابحث عن دكتور',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'لأن صحتك تستحق الأفضل',
          style: TextStyle(fontSize: 13, color: Color(0xFFDCEBFF)),
        ),
        const SizedBox(height: 18),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              SvgPicture.asset('${_icons}search.svg', width: 20, height: 20),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() => _query = value);
                  },
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      _openResults(query: value.trim());
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'ابحث باسم الدكتور أو المنطقة',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (_query.isNotEmpty)
                IconButton(
                  tooltip: 'مسح البحث',
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    _controller.clear();
                    setState(() => _query = '');
                  },
                ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _specialtyRow((String, String) specialty) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _openResults(specialty: specialty.$1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFE0ECFA)),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                padding: const EdgeInsets.all(9),
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF3FF),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('$_icons${specialty.$2}'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  specialty.$1,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _dark,
                  ),
                ),
              ),
              const Icon(Icons.chevron_left, color: Colors.blueGrey),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _doctorSuggestion(SearchDoctor doctor) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _openResults(query: doctor.name),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFE0ECFA)),
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/search-results-screen/images/${doctor.image}',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 48,
                    height: 48,
                    color: const Color(0xFFEAF3FF),
                    alignment: Alignment.center,
                    child: const Icon(Icons.person, color: _primary, size: 27),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${doctor.title} ${doctor.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${doctor.specialty} • ${doctor.area}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left, color: Colors.blueGrey),
            ],
          ),
        ),
      ),
    ),
  );
}
