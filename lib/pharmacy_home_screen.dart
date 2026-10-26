import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_bottom_nav_bar.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({super.key});

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  int currentIndex = 3;
  String searchQuery = '';

  static const String imagePath = 'assets/pharmacy-home-screen/images/';
  static const String iconPath = 'assets/pharmacy-home-screen/icons/';

  final List<Map<String, String>> categories = [
    {'title': 'أدوية عامة', 'image': 'general_medicines.png'},
    {
      'title': 'أدوية الأمراض المزمنة',
      'image': 'chronic_disease_medications.png',
    },
    {'title': 'المستلزمات الطبية', 'image': 'medical_supplies.jpeg'},
    {'title': 'منتجات الأطفال', 'image': 'baby_products.jpeg'},
    {'title': 'العناية الشخصية', 'image': 'personal_care.jpeg'},
    {
      'title': 'فيتامينات ومكملات غذائية',
      'image': 'vitamins_and_supplements.jpeg',
    },
    {'title': 'العناية بالبشرة والشعر', 'image': 'skin_and_hair_care.jpeg'},
    {'title': 'أجهزة طبية', 'image': 'medical_devices.jpeg'},
    {'title': 'أدوات صحية', 'image': 'healthcare_supplies.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories.where((category) {
      return category['title']!.contains(searchQuery.trim());
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5FAFE),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                        child: _buildHeader(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
                        child: _buildBanner(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(true),
                            _buildDot(false),
                            _buildDot(false),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 24, 22, 12),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            SvgPicture.asset(
                              '${iconPath}apps.svg',
                              width: 22,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF0875E1),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'أقسام الصيدلية',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF123568),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: _buildSearchField(),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 0),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final category = filteredCategories[index];
                          return _buildCategoryCard(category);
                        }, childCount: filteredCategories.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.78,
                            ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
                        child: _buildTrustBanner(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 76,
      child: Row(
        children: [
          _buildCartIcon(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logo_text-removebg-preview.png',
                  height: 48,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey,
                      size: 30,
                    );
                  },
                ),
                const Text(
                  'صحتك .. في مكان واحد',
                  style: TextStyle(fontSize: 11, color: Color(0xFF8293A8)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 190,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFFB9DFFF), Color(0xFFE1F2FF)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: -30,
            bottom: -30,
            width: 350,
            child: Image.asset(
              '${imagePath}pharmacy-home-screen_image-removebg-preview.png',
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.medication_rounded,
                  size: 110,
                  color: Color(0xFF779ec7),
                );
              },
            ),
          ),
          Positioned(
            right: 16,
            left: 150,
            top: 24,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'صيدليتك\nأقرب لك',
                  style: TextStyle(
                    fontSize: 27,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF103365),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'جميع الأدوية والمستلزمات الطبية\nبأمان وسهولة',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Color(0xFF36577A),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchQuery = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0875E1),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: const Size(0, 34),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'تصفح المنتجات  ‹',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: selected ? 18 : 7,
      height: 7,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0875E1) : const Color(0xFFD8E7F4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      textDirection: TextDirection.rtl,
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'ابحث عن دواء أو منتج...',
        hintStyle: const TextStyle(color: Color(0xFF9AA8B8), fontSize: 13),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            '${iconPath}search.svg',
            width: 19,
            height: 19,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFFE3EBF3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF0875E1)),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, String> category) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('اخترتِ ${category['title']}')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEAF0F6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x080D2858),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    '$imagePath${category['image']}',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.medical_services_outlined,
                        size: 42,
                        color: Color(0xFF0875E1),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 36,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    category['title']!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF17365F),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  '${iconPath}chevron-right.svg',
                  width: 15,
                  height: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F3FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SvgPicture.asset('${iconPath}protection.svg', width: 28, height: 28),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'منتجات أصلية 100%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF24517F),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'من أفضل الماركات العالمية والمحلية',
                  style: TextStyle(fontSize: 11, color: Color(0xFF6B8EAF)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSvgIcon(String path, {double size = 24, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Color(0xFF123568), BlendMode.srcIn),
      ),
    );
  }

  Widget _buildCartIcon() {
    return SizedBox(
      width: 34,
      height: 34,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildSvgIcon('${iconPath}cart.svg', size: 30, onTap: () {}),
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF1687E8),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
