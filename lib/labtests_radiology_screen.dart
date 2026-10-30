import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const DoctoracApp());
}

const Color primaryBlue = Color(0xFF0875E1);
const Color darkBlue = Color(0xFF10366D);
const Color lightBlue = Color(0xFFEAF4FF);
const Color borderColor = Color(0xFFD8E7F5);
const Color backgroundColor = Color(0xFFF5FAFF);
class DoctoracApp extends StatelessWidget {
  const DoctoracApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctorac',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
      ),
      home: const LabTestsRadiologyScreen(),
    );
  }
}

class MedicalCenter {
  final String name;
  final String imagePath;
  final String rating;
  final String distance;
  final String location;
  final String services;
  final String category;
  final List<String> supportedCategories;

  const MedicalCenter({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.distance,
    required this.location,
    required this.services,
    required this.category,
    required this.supportedCategories,
  });
}

class LabTestsRadiologyScreen extends StatefulWidget {
  const LabTestsRadiologyScreen({super.key});

  @override
  State<LabTestsRadiologyScreen> createState() =>
      _LabTestsRadiologyScreenState();
}

class _LabTestsRadiologyScreenState
    extends State<LabTestsRadiologyScreen> {
  int selectedTab = 0;
  int selectedBottom = 3;
  int selectedCategory = -1;

  final TextEditingController searchController = TextEditingController();

  final List<String> labCategories = [
    'هرمونات',
    'فيتامينات',
    'وظائف الكبد',
    'تحليل البول',
    'صورة دم كاملة',
  ];

  final List<String> labImagePaths = [
    'assets/lab_tests_screen/icons/hormones.svg',
    'assets/lab_tests_screen/icons/vitamins.svg',
    'assets/lab_tests_screen/icons/liver.svg',
    'assets/lab_tests_screen/icons/bladder.svg',
    'assets/lab_tests_screen/icons/blood-1.svg',
  ];

  final List<String> radiologyCategories = [
    'ماموجرام',
    'موجات صوتية',
    'أشعة مقطعية',
    'رنين مغناطيسي',
    'أشعة سينية',
  ];

  final List<String> radiologyImagePaths = [
    'assets/radiology-screen/icons/mammogram.svg',
    'assets/radiology-screen/icons/Ultrasound.svg',
    'assets/radiology-screen/icons/mri-machine.svg',
    'assets/radiology-screen/icons/radiology.svg',
    'assets/radiology-screen/icons/X-ray.svg',
  ];

  final List<MedicalCenter> labs = const [
    MedicalCenter(
      name: 'الأهرام للتحاليل',
      imagePath: 'assets/radiology-screen/images/radiology_03.jpeg',
      rating: '4.8',
      distance: '1.2 كم',
      location: 'الزمالك القاهرة',
      services: 'تحاليل طبية هرمونات فيتامينات',
      category: 'تحاليل',
      supportedCategories: [
        'هرمونات',
        'فيتامينات',
        'صورة دم كاملة',
      ],
    ),
    MedicalCenter(
      name: 'كايرو سكان',
      imagePath: 'assets/radiology-screen/images/radiology_02.jpeg',
      rating: '4.6',
      distance: '2.5 كم',
      location: 'مدينة نصر القاهرة',
      services: 'صورة دم سكر وظائف كبد',
      category: 'تحاليل',
      supportedCategories: [
        'صورة دم كاملة',
        'تحليل البول',
        'وظائف الكبد',
      ],
    ),
    MedicalCenter(
      name: 'معامل البرج',
      imagePath: 'assets/lab_tests_screen/images/lab_02.jpeg',
      rating: '4.7',
      distance: '3.1 كم',
      location: 'التجمع الخامس القاهرة',
      services: 'تحاليل طبية فيتامينات مناعة',
      category: 'تحاليل',
      supportedCategories: [
        'هرمونات',
        'فيتامينات',
        'تحليل البول',
        'وظائف الكبد',
      ],
    ),
  ];

  final List<MedicalCenter> radiologyCenters = const [
    MedicalCenter(
      name: 'مركز دار الطب للأشعة',
      imagePath: 'assets/lab_tests_screen/images/lab_01.jpeg',
      rating: '4.9',
      distance: '0.9 كم',
      location: 'الزمالك القاهرة',
      services: 'أشعة مقطعية رنين مغناطيسي',
      category: 'أشعة',
      supportedCategories: [
        'أشعة مقطعية',
        'رنين مغناطيسي',
      ],
    ),
    MedicalCenter(
      name: 'كابيتال سكان',
      imagePath: 'assets/radiology-screen/images/radiology_01.jpeg',
      rating: '4.6',
      distance: '2.8 كم',
      location: 'مدينة نصر القاهرة',
      services: 'أشعة سينية موجات صوتية',
      category: 'أشعة',
      supportedCategories: [
        'أشعة سينية',
        'موجات صوتية',
      ],
    ),
    MedicalCenter(
      name: 'مركز البرج للأشعة',
      imagePath: 'assets/lab_tests_screen/images/lab_02.jpeg',
      rating: '4.7',
      distance: '3.5 كم',
      location: 'التجمع الخامس القاهرة',
      services: 'أشعة مقطعية موجات صوتية',
      category: 'أشعة',
      supportedCategories: [
        'أشعة مقطعية',
        'موجات صوتية',
      ],
    ),
  ];

  List<MedicalCenter> get filteredCenters {
    final centers = selectedTab == 0 ? labs : radiologyCenters;
    final query = searchController.text.trim().toLowerCase();

    final categories =
    selectedTab == 0 ? labCategories : radiologyCategories;

    final selectedName = selectedCategory >= 0
        ? categories[selectedCategory]
        : null;

    return centers.where((center) {
      final matchName = center.name.toLowerCase().contains(query);
      final matchLocation = center.location.toLowerCase().contains(query);
      final matchServices = center.services.toLowerCase().contains(query);
      final matchCategory = center.supportedCategories.any(
            (service) => service.toLowerCase().contains(query),
      );

      final matchesSearch = query.isEmpty ||
          matchName ||
          matchLocation ||
          matchServices ||
          matchCategory;

      final matchesCategoryFilter = selectedName == null ||
          center.supportedCategories.contains(selectedName);

      return matchesSearch && matchesCategoryFilter;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void switchTab(int index) {
    setState(() {
      selectedTab = index;
      selectedCategory = -1;
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 14),
                      _buildTabs(),
                      const SizedBox(height: 22),
                      _buildSectionTitle(
                        selectedTab == 0
                            ? 'أشهر التحاليل'
                            : 'أشهر أنواع الأشعة',
                      ),
                      const SizedBox(height: 12),
                      _buildCategories(),
                      const SizedBox(height: 24),
                      _buildCentersHeader(),
                      const SizedBox(height: 12),
                      ...filteredCenters.map(
                            (center) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildCenterCard(center),
                        ),
                      ),
                      if (filteredCenters.isEmpty) _buildEmptyState(),
                      const SizedBox(height: 6),
                      _buildHealthNotice(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (selectedTab == 1) {
                switchTab(0);
              }
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: darkBlue,
              size: 23,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 40,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedTab == 0 ? 'التحاليل' : 'الأشعة',
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedTab == 0
                      ? 'احجز تحاليلك من أقرب المراكز الطبية'
                      : 'احجز أشعتك من أقرب المراكز الطبية',
                  style: const TextStyle(
                    color: Color(0xFF8A9DB2),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(
            'assets/logo/logo_text1.png',
            width: 112,
            height: 42,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return const Text(
                'Doctorac',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD6E4F5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: selectedTab == 0
              ? 'ابحث عن تحليل، أو مركز ...'
              : 'ابحث عن نوع الأشعة أو مركز ...',
          hintStyle: const TextStyle(
            color: Color(0xFF9AB2C7),
            fontSize: 12,
          ),
          hintTextDirection: TextDirection.rtl,
          suffixIcon: const Padding(
            padding: EdgeInsets.only(right: 14, left: 8),
            child: Icon(
              Icons.search,
              color: Color(0xFF7893B1),
              size: 21,
            ),
          ),
          prefixIcon: searchController.text.isNotEmpty
              ? IconButton(
            onPressed: () {
              searchController.clear();
              setState(() {});
            },
            icon: const Icon(
              Icons.close,
              size: 17,
              color: Color(0xFF7893B1),
            ),
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD6E4F5)),
      ),
      child: Row(
        children: [
          _buildTab(
            title: 'الأشعة',
            icon: Icons.document_scanner_outlined,
            index: 1,
          ),
          _buildTab(
            title: 'التحاليل',
            icon: Icons.biotech_outlined,
            index: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required IconData icon,
    required int index,
  }) {
    final selected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => switchTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
            boxShadow: selected
                ? [
              BoxShadow(
                color: primaryBlue.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w600,
                  color: selected ? Colors.white : const Color(0xFF6B87A4),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                size: 18,
                color: selected ? Colors.white : const Color(0xFF6B87A4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: darkBlue,
      ),
    );
  }

  Widget _buildCategories() {
    final categories =
    selectedTab == 0 ? labCategories : radiologyCategories;
    final imagePaths = selectedTab == 0 ? labImagePaths : radiologyImagePaths;

    return SizedBox(
      height: 91,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final selected = selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory =
                selectedCategory == index ? -1 : index;
                searchController.clear();
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 83,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: selected ? lightBlue : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? primaryBlue : borderColor,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: SvgPicture.asset(
                      imagePaths[index],
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                        primaryBlue,
                        BlendMode.srcIn,
                      ),
                      placeholderBuilder: (context) => const Icon(
                        Icons.medical_services_outlined,
                        color: primaryBlue,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categories[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCentersHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedTab == 0
                ? 'مراكز التحاليل القريبة منك'
                : 'مراكز الأشعة القريبة منك',
            style: const TextStyle(
              color: darkBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              selectedCategory = -1;
              searchController.clear();
            });
          },
          icon: const Icon(Icons.arrow_back_ios, size: 13),
          label: const Text(
            'عرض الكل',
            style: TextStyle(fontSize: 12),
          ),
          style: TextButton.styleFrom(
            foregroundColor: primaryBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterCard(MedicalCenter center) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE0ECF7),
        ),
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF174A7E).withValues(alpha: 0.045),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 68,
            child: ElevatedButton.icon(
              onPressed: () => _showBookingDialog(center),
              icon: const Icon(
                Icons.arrow_forward,
                size: 12,
              ),
              label: const Text(
                'احجز الآن',
                style: TextStyle(fontSize: 10),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 9,
                ),
                minimumSize: const Size(0, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  center.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  runSpacing: 2,
                  children: [
                    const Icon(
                      Icons.verified,
                      color: primaryBlue,
                      size: 12,
                    ),
                    const Text(
                      'مركز معتمد',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF73869B),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFB629),
                      size: 12,
                    ),
                    Text(
                      center.rating,
                      style: const TextStyle(
                        fontSize: 10,
                        color: darkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        center.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF73869B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: primaryBlue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      center.distance,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF73869B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 4,
                  runSpacing: 4,
                  children: center.supportedCategories.take(3).map(
                        (service) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          service,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF6790B4),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 9),
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor),
            ),
            child: ClipOval(
              child: Image.asset(
                center.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Center(
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: primaryBlue,
                      size: 26,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDialog(MedicalCenter center) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'حجز موعد',
            style: TextStyle(
              color: darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                center.name,
                style: const TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'تم تأكيد الحجز',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إغلاق'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('حسناً'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: const Column(
        children: [
          Icon(
            Icons.search_off,
            size: 45,
            color: Color(0xFF9CB6CE),
          ),
          SizedBox(height: 10),
          Text(
            'لا توجد مراكز تقدم هذا النوع حاليًا',
            style: TextStyle(
              color: Color(0xFF73869B),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthNotice() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'جميع المعامل معتمدة ومرخصة من وزارة الصحة',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF4B91CC),
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.verified_user_outlined,
            color: Color(0xFF1687E8),
            size: 17,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    const items = [
      (Icons.person_outline, 'حسابي'),
      (Icons.account_balance_wallet_outlined, 'محفظتي'),
      (Icons.calendar_month_outlined, 'مواعيدي'),
      (Icons.home_outlined, 'الرئيسية'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 66,
          child: Row(
            children: List.generate(items.length, (index) {
              final selected = selectedBottom == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() => selectedBottom = index);

                    if (index != 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'قسم ${items[index].$2} ',
                          ),
                          duration: const Duration(milliseconds: 900),
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[index].$1,
                        color: selected
                            ? primaryBlue
                            : const Color(0xFF8297AC),
                        size: 23,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        items[index].$2,
                        style: TextStyle(
                          fontSize: 10,
                          color: selected
                              ? primaryBlue
                              : const Color(0xFF8297AC),
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (selected)
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 23,
                          height: 2,
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}