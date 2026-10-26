import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ==========================================
// DOCTOR MODEL
// ==========================================
class Doctor {
  final String id;
  final String name;
  final String title;
  final String specialty;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final int price;
  final String location;
  final String imagePath;
  final String about;
  final List<String> specialties;
  final LatLng coordinates;

  const Doctor({
    required this.id,
    required this.name,
    required this.title,
    required this.specialty,
    required this.rating,
    required this.reviewsCount,
    required this.experienceYears,
    required this.price,
    required this.location,
    required this.imagePath,
    required this.about,
    required this.specialties,
    required this.coordinates,
  });
}

// ==========================================
// DOCTOR DETAILS SCREEN
// ==========================================
class DoctorDetailsScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  int selectedDateIndex = 1;
  int selectedTimeIndex = 1; // تم ضبط الاختيار الافتراضي بما يتناسب مع القائمة الجديدة
  bool isAboutExpanded = false;

  final List<Map<String, String>> dates = [
    {'day': 'السبت', 'date': '26 أبريل'},
    {'day': 'الأحد', 'date': '27 أبريل'},
    {'day': 'الإثنين', 'date': '28 أبريل'},
    {'day': 'الثلاثاء', 'date': '29 أبريل'},
    {'day': 'الأربعاء', 'date': '30 أبريل'},
  ];

  // تم تقليل عدد المواعيد إلى 4 فترات واضحة
  final List<String> timeSlots = [
    '10:30 ص',
    '01:00 م',
    '05:00 م',
    '08:00 م',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/doctor-home-care-screen/icons/chevron-left.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Color(0xFF1E293B),
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // ==========================================
            // 1. DOCTOR PROFILE HEADER (الصورة والتفاصيل)
            // ==========================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الصورة مع الإطار السماوي المزدوج وعلامة التواجد
                _buildDoctorAvatarWithHalo(),
                const SizedBox(width: 16),

                // بيانات الطبيب والتقييم
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F3E78),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // التقييم: الرقم أولاً ثم النجمة الصفراء ثم عدد التقييمات
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.doctor.rating}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB800),
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${widget.doctor.reviewsCount} تقييم)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.doctor.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'خبرة ${widget.doctor.experienceYears} سنة',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ==========================================
            // 2. FEATURE BADGES (تم حل الـ Overflow هنا)
            // ==========================================
            Row(
              children: [
                _buildModernFeatureBadge(
                  svgPath: 'assets/doctor-home-care-screen/icons/protection.svg',
                  line1: 'معتمد من',
                  line2: 'وزارة الصحة',
                ),
                const SizedBox(width: 8),
                _buildModernFeatureBadge(
                  svgPath: 'assets/doctor-home-care-screen/icons/home.svg',
                  line1: 'متاح للزيارة',
                  line2: 'المنزلية',
                ),
                const SizedBox(width: 8),
                _buildModernFeatureBadge(
                  iconData: Icons.chat_bubble_outline_rounded,
                  line1: 'يتحدث العربية',
                  line2: 'والإنجليزية',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ==========================================
            // ABOUT DOCTOR
            // ==========================================
            const Text(
              'نبذة عن الطبيب',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.doctor.about,
              maxLines: isAboutExpanded ? 10 : 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Color(0xFF64748B),
              ),
            ),
            InkWell(
              onTap: () => setState(() => isAboutExpanded = !isAboutExpanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isAboutExpanded ? 'عرض أقل' : 'عرض المزيد',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/doctor-home-care-screen/icons/chevron-down.svg',
                      width: 12,
                      height: 12,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1565C0),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 32, thickness: 0.8),

            // ==========================================
            // SPECIALTIES
            // ==========================================
            const Text(
              'التخصصات',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.doctor.specialties
                  .map((spec) => _buildTagChip(spec))
                  .toList(),
            ),
            const Divider(height: 32, thickness: 0.8),

            // ==========================================
            // ADDRESS & REAL MAP
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'العنوان',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/doctor-home-care-screen/icons/location-1.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1565C0),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.doctor.location} - القاهرة',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildRealMapWidget(),
            const SizedBox(height: 24),

            // ==========================================
            // AVAILABLE DAYS
            // ==========================================
            const Text(
              'الأيام المتاحة',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDateIndex = index),
                    child: Container(
                      width: 75,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1565C0)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1565C0)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dates[index]['day']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dates[index]['date']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected
                                  ? Colors.white.withOpacity(0.9)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // TIME SLOTS DURING DAY
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'المواعيد المتاحة خلال اليوم',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  '${dates[selectedDateIndex]['day']} (${dates[selectedDateIndex]['date']})',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(timeSlots.length, (index) {
                final isSelected = selectedTimeIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedTimeIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1565C0)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1565C0)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          size: 14,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          timeSlots[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 110),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => _confirmBooking(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'احجز موعد الزيارة المنزلية',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET: DOCTOR AVATAR WITH HALO & DOT
  // ==========================================
  Widget _buildDoctorAvatarWithHalo() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 108,
          height: 108,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFD3E6FE),
              width: 2.2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                widget.doctor.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 6,
          child: Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // WIDGET: MODERN FEATURE BADGE (تم حل الـ Overflow)
  // ==========================================
  Widget _buildModernFeatureBadge({
    String? svgPath,
    IconData? iconData,
    required String line1,
    required String line2,
  }) {
    return Expanded(
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F9FE),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE9F1FC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    line1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  Text(
                    line2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF1565C0),
                  BlendMode.srcIn,
                ),
              )
            else if (iconData != null)
              Icon(iconData, size: 18, color: const Color(0xFF1565C0)),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // WIDGET: REAL MAP
  // ==========================================
  Widget _buildRealMapWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: widget.doctor.coordinates,
                initialZoom: 14.5,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.doctorac.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: widget.doctor.coordinates,
                      width: 80,
                      height: 60,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1565C0),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'موقع الطبيب',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            size: 32,
                            color: Color(0xFFE11D48),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: const Color(0xFFF8FAFC),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/doctor-home-care-screen/icons/home.svg',
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF1565C0),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'يمكنك طلب الزيارة للمنزل في نفس هذه المنطقة',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF334155),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmBooking(BuildContext context) {
    final selectedDay = dates[selectedDateIndex]['day'];
    final selectedDate = dates[selectedDateIndex]['date'];
    final selectedTime = timeSlots[selectedTimeIndex];

    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF1565C0),
                  size: 26,
                ),
                SizedBox(width: 8),
                Text(
                  'تأكيد موعد الزيارة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الطبيب: ${widget.doctor.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text('اليوم: $selectedDay ($selectedDate)'),
                const SizedBox(height: 6),
                Text(
                  'الوقت المختار: $selectedTime',
                  style: const TextStyle(
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text('الموقع: ${widget.doctor.location}'),
                const SizedBox(height: 6),
                Text(
                  'قيمة الكشف: ${widget.doctor.price} ج.م',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('تعديل'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'تم تأكيد حجزك مع ${widget.doctor.name} يوم $selectedDay الساعة $selectedTime',
                      ),
                      backgroundColor: const Color(0xFF1565C0),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                ),
                child: const Text(
                  'تأكيد الحجز النهائي',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
      ),
    );
  }
}