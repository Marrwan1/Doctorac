import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'search_results_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _bg,
        body: Column(
          children: [
            _header(context),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 22, 20, 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'اختار التخصص',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _dark,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _specialties.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (_, i) => _card(context, _specialties[i]),
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
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث بالتخصص أو اسم الدكتور',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _card(BuildContext context, (String, String) s) => InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SearchResultsScreen(specialty: s.$1)),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0875E1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
              color: Color(0xFFEAF3FF),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset('$_icons${s.$2}'),
          ),
          const SizedBox(height: 10),
          Text(
            s.$1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _dark,
            ),
          ),
        ],
      ),
    ),
  );
}
