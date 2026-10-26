import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'doctor_details.dart';

void main() {
  runApp(const DoctorHomeCareApp());
}

class DoctorHomeCareApp extends StatelessWidget {
  const DoctorHomeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctorac',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: const Color(0xFF1565C0),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          primary: const Color(0xFF1565C0),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: DoctorHomeCareScreen(),
      ),
    );
  }
}

// ==========================================
// MOCK DOCTORS DATA
// ==========================================
final List<Doctor> allMockDoctors = [
  const Doctor(
    id: '1',
    name: 'د. أحمد محمد علي',
    title: 'أخصائي الباطنة العامة',
    specialty: 'باطنة عامة',
    rating: 4.9,
    reviewsCount: 320,
    experienceYears: 12,
    price: 600,
    location: 'الزمالك',
    imagePath: 'assets/doctor-home-care-screen/images/doctor_03.png',
    about:
        'استشاري باطنة عامة، حاصل على ماجستير الأمراض الباطنية من جامعة القاهرة. خبرة واسعة في تشخيص وعلاج الأمراض المزمنة والمشكلات الصحية العامة ومتابعة كبار السن بالمنزل.',
    specialties: ['الباطنة العامة', 'أمراض الجهاز الهضمي', 'متابعة الأمراض المزمنة'],
    coordinates: LatLng(30.0617, 31.2195),
  ),
  const Doctor(
    id: '2',
    name: 'د. منى السيد',
    title: 'أخصائي طب الأطفال',
    specialty: 'أطفال',
    rating: 4.8,
    reviewsCount: 245,
    experienceYears: 10,
    price: 550,
    location: 'مدينة نصر',
    imagePath: 'assets/doctor-home-care-screen/images/doctor_02.png',
    about:
        'استشارية طب الأطفال وحديثي الولادة، متخصصة في متابعة النمو والتغذية العلاجية ورعاية الحالات الطارئة والتطعيمات.',
    specialties: ['طب الأطفال', 'حديثي الولادة', 'تغذية علاجية'],
    coordinates: LatLng(30.0561, 31.3444),
  ),
  const Doctor(
    id: '3',
    name: 'د. كريم شحاتة',
    title: 'أخصائي الأنف والأذن والحنجرة',
    specialty: 'أنف وأذن وحنجرة',
    rating: 4.7,
    reviewsCount: 190,
    experienceYears: 8,
    price: 450,
    location: 'الشيخ زايد',
    imagePath: 'assets/doctor-home-care-screen/images/doctor_01.png',
    about:
        'أخصائي جراحة الأنف والأذن والحنجرة، متابعة حالات الحساسية، الجيوب الأنفية ومشاكل السمع والاتزان.',
    specialties: ['أنف وأذن وحنجرة', 'علاج الجيوب الأنفية', 'طنين الأذن'],
    coordinates: LatLng(30.0255, 30.9859),
  ),
  const Doctor(
    id: '4',
    name: 'د. عمر خالد',
    title: 'استشاري جراحة العظام والمفاصل',
    specialty: 'عظام',
    rating: 4.9,
    reviewsCount: 410,
    experienceYears: 15,
    price: 700,
    location: 'المعادي',
    imagePath: 'assets/doctor-home-care-screen/images/doctor_04.png',
    about:
        'استشاري جراحة العظام والمفاصل والعمود الفقري وإصابات الملاعب وتأهيل ما بعد الجراحات والإصابات الحركية بالمنزل.',
    specialties: ['جراحة العظام', 'إصابات الملاعب', 'خشونة المفاصل'],
    coordinates: LatLng(29.9602, 31.2569),
  ),
  const Doctor(
    id: '5',
    name: 'د. طارق إبراهيم',
    title: 'أخصائي أمراض القلب والأوعية الدموية',
    specialty: 'قلب وأوعية دموية',
    rating: 4.8,
    reviewsCount: 280,
    experienceYears: 11,
    price: 650,
    location: 'الدقي',
    imagePath: 'assets/doctor-home-care-screen/images/doctor_05.png',
    about:
        'أخصائي أمراض القلب والأوعية الدموية، رسم قلب منزلي، متابعة ضغط الدم ومرضى القصور القلبي وإعادة التأهيل.',
    specialties: ['أمراض القلب', 'رسم قلب منزلي', 'متابعة ضغط الدم'],
    coordinates: LatLng(30.0385, 31.2124),
  ),
];

// ==========================================
// DOCTOR HOME CARE SCREEN
// ==========================================
class DoctorHomeCareScreen extends StatefulWidget {
  const DoctorHomeCareScreen({super.key});

  @override
  State<DoctorHomeCareScreen> createState() => _DoctorHomeCareScreenState();
}

class _DoctorHomeCareScreenState extends State<DoctorHomeCareScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedSpecialty = 'الكل';
  String selectedArea = 'الكل';
  String selectedPriceSort = 'الافتراضي';
  bool showAll = false;

  final List<String> specialtiesList = [
    'الكل',
    'باطنة عامة',
    'أطفال',
    'أنف وأذن وحنجرة',
    'عظام',
    'قلب وأوعية دموية',
  ];

  final List<String> areasList = [
    'الكل',
    'الزمالك',
    'مدينة نصر',
    'الشيخ زايد',
    'المعادي',
    'الدقي',
  ];

  final List<String> priceOptions = [
    'الافتراضي',
    'الأقل سعراً',
    'الأعلى سعراً',
    'أقل من 500 ج.م',
    'أكثر من 600 ج.م',
  ];

  List<Doctor> get filteredDoctors {
    List<Doctor> list = List.from(allMockDoctors);

    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((doc) {
        return doc.name.toLowerCase().contains(query) ||
            doc.title.toLowerCase().contains(query) ||
            doc.location.toLowerCase().contains(query) ||
            doc.specialty.toLowerCase().contains(query);
      }).toList();
    }

    if (selectedSpecialty != 'الكل') {
      list = list.where((doc) => doc.specialty == selectedSpecialty).toList();
    }

    if (selectedArea != 'الكل') {
      list = list.where((doc) => doc.location == selectedArea).toList();
    }

    if (selectedPriceSort == 'الأقل سعراً') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedPriceSort == 'الأعلى سعراً') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedPriceSort == 'أقل من 500 ج.م') {
      list = list.where((doc) => doc.price < 500).toList();
    } else if (selectedPriceSort == 'أكثر من 600 ج.م') {
      list = list.where((doc) => doc.price > 600).toList();
    }

    return list;
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      selectedSpecialty = 'الكل';
      selectedArea = 'الكل';
      selectedPriceSort = 'الافتراضي';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorsToDisplay =
        showAll ? filteredDoctors : filteredDoctors.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/doctor-home-care-screen/icons/chevron-left.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1E293B),
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'زيارة طبيب في المنزل',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'استشر طبيبك من راحة بيتك بكل أمان وسهولة',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Enhanced Hero Banner
              _buildServiceBanner(),
              const SizedBox(height: 16),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/doctor-home-care-screen/icons/search.svg',
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF94A3B8),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'ابحث عن دكتور أو تخصص أو منطقة ...',
                          hintStyle: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Filter Chips Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterPill(
                      label: selectedPriceSort == 'الافتراضي'
                          ? 'السعر'
                          : selectedPriceSort,
                      isActive: selectedPriceSort != 'الافتراضي',
                      hasDropdown: true,
                      onTap: () => _openSelectionSheet(
                        title: 'تحديد السعر والترتيب',
                        options: priceOptions,
                        currentValue: selectedPriceSort,
                        onSelected: (val) =>
                            setState(() => selectedPriceSort = val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterPill(
                      label: selectedArea == 'الكل' ? 'المنطقة' : selectedArea,
                      isActive: selectedArea != 'الكل',
                      hasDropdown: true,
                      onTap: () => _openSelectionSheet(
                        title: 'اختر المنطقة',
                        options: areasList,
                        currentValue: selectedArea,
                        onSelected: (val) =>
                            setState(() => selectedArea = val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterPill(
                      label: selectedSpecialty == 'الكل'
                          ? 'التخصص'
                          : selectedSpecialty,
                      isActive: selectedSpecialty != 'الكل',
                      hasDropdown: true,
                      onTap: () => _openSelectionSheet(
                        title: 'اختر التخصص',
                        options: specialtiesList,
                        currentValue: selectedSpecialty,
                        onSelected: (val) =>
                            setState(() => selectedSpecialty = val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterPill(
                      label: 'تصفية',
                      svgIconPath:
                          'assets/doctor-home-care-screen/icons/slider-settings.svg',
                      isActive: selectedSpecialty != 'الكل' ||
                          selectedArea != 'الكل' ||
                          selectedPriceSort != 'الافتراضي',
                      onTap: () => _showFilterOptionsDialog(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section Header with Show All toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'أطباء متاحين للزيارة المنزلية (${filteredDoctors.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          showAll ? 'عرض أقل' : 'عرض الكل',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1565C0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          showAll
                              ? Icons.keyboard_arrow_up
                              : Icons.arrow_back_ios,
                          size: showAll ? 16 : 10,
                          color: const Color(0xFF1565C0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Doctor List
              if (doctorsToDisplay.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.search_off_rounded,
                        size: 50,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'لا يوجد أطباء يطابقون خيارات البحث الحالية',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      TextButton(
                        onPressed: _clearFilters,
                        child: const Text('إعادة ضبط الفلاتر'),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  itemCount: doctorsToDisplay.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _buildDoctorCard(context, doctorsToDisplay[index]),
                ),

              const SizedBox(height: 16),

              // Ministry Certified Notice
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/doctor-home-care-screen/icons/protection.svg',
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1565C0),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'جميع الأطباء معتمدون ومرخصون من وزارة الصحة',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceBanner() {
    return Container(
      width: double.infinity,
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0A4FB3),
            Color(0xFF1976D2),
            Color(0xFF2196F3),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: 100,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 190,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.55, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/doctor-home-care-screen/images/home_doctor_visit_01.jpeg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/doctor-home-care-screen/images/home_doctor_visit.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 14.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/doctor-home-care-screen/icons/home.svg',
                          width: 13,
                          height: 13,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'زيارة طبيب للمنزل',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildProBannerBullet(
                  'أطباء استشاريون متخصصون',
                  'assets/doctor-home-care-screen/icons/specialized_doctors.svg',
                ),
                const SizedBox(height: 7),
                _buildProBannerBullet(
                  'مواعيد مرنة حسب وقتك',
                  'assets/doctor-home-care-screen/icons/flexible_appointments.svg',
                ),
                const SizedBox(height: 7),
                _buildProBannerBullet(
                  'خدمة آمنة ومعتمدة 100%',
                  'assets/doctor-home-care-screen/icons/safe_and_reliable_service.svg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProBannerBullet(String title, String svgPath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          padding: const EdgeInsets.all(3.5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: SvgPicture.asset(
            svgPath,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPill({
    required String label,
    String? svgIconPath,
    bool hasDropdown = false,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1565C0) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? const Color(0xFF1565C0) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgIconPath != null) ...[
              SvgPicture.asset(
                svgIconPath,
                width: 15,
                height: 15,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : const Color(0xFF64748B),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.white : const Color(0xFF475569),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 6),
              SvgPicture.asset(
                'assets/doctor-home-care-screen/icons/chevron-down.svg',
                width: 11,
                height: 11,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : const Color(0xFF64748B),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _openSelectionSheet({
    required String title,
    required List<String> options,
    required String currentValue,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const Divider(height: 20),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    itemBuilder: (context, index) {
                      final opt = options[index];
                      final isSelected = opt == currentValue;
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        title: Text(
                          opt,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF1565C0)
                                : const Color(0xFF334155),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: Color(0xFF1565C0),
                              )
                            : null,
                        onTap: () {
                          onSelected(opt);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterOptionsDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'خيارات التصفية',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.refresh, color: Colors.red),
                  title: const Text(
                    'إعادة ضبط ومسح كافة الفلاتر',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    _clearFilters();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.check, color: Color(0xFF1565C0)),
                  title: const Text('إظهار كل الأطباء'),
                  onTap: () {
                    setState(() => showAll = true);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ====================================================================
  // كارت الطبيب بعد تطبيق التعديلات الثلاثة المطلوبة
  // ====================================================================
  Widget _buildDoctorCard(BuildContext context, Doctor doctor) {
    return InkWell(
      onTap: () => _navigateToDetails(context, doctor),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEF2F6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. الدائرة الخضراء مصمتة بالكامل وممتلئة مع إطار أبيض
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xFFE2E8F0),
                      backgroundImage: AssetImage(doctor.imagePath),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E), // أخضر ممتلئ بالكامل
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2), // إطار أبيض
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // 2. الترتيب: الرقم أولاً ثم النجمة الصفراء الممتلئة ثم عدد التقييمات
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${doctor.rating}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB800), // نجمة صفراء ممتلئة بالكامل
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${doctor.reviewsCount} تقييم)',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),
                      Text(
                        doctor.title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'خبرة ${doctor.experienceYears} سنة',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 0.8, color: Color(0xFFF1F5F9)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToDetails(context, doctor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'احجز الآن',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/doctor-home-care-screen/icons/arrow-right.svg',
                        width: 12,
                        height: 12,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${doctor.price} ج.م',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/doctor-home-care-screen/icons/location-1.svg',
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF94A3B8),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: DoctorDetailsScreen(doctor: doctor),
        ),
      ),
    );
  }
}