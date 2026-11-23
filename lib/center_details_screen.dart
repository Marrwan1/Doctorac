import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Home.dart' show CenterData, C, AppImage, cardDeco;

class CenterDetailsScreen extends StatelessWidget {
  final CenterData center;
  const CenterDetailsScreen({super.key, required this.center});

  LatLng get _point => LatLng(center.lat, center.lng);

  // يفتح جوجل ماب على نقطة المركز
  Future<void> _openGoogleMaps(BuildContext context) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${center.lat},${center.lng}',
    );
    var opened = false;
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح خرائط جوجل')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
          children: [
            _topBar(context),
            const SizedBox(height: 14),
            _photo(),
            const SizedBox(height: 16),
            _infoCard(),
            const SizedBox(height: 20),
            const Text(
              'الموقع',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: C.text),
            ),
            const SizedBox(height: 12),
            _gpsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) => Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(color: C.circle, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_rounded, color: C.primary, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              center.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: C.text),
            ),
          ),
        ],
      );

  Widget _photo() => Container(
        decoration: cardDeco(r: 22),
        padding: const EdgeInsets.all(6),
        child: AppImage(center.photo, width: double.infinity, height: 200, radius: 18),
      );

  Widget _infoCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: cardDeco(r: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE3E9F2)),
                  ),
                  child: ClipOval(
                    child: AppImage(center.logo, width: 62, height: 62, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    center.name,
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: C.text),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _infoRow(Icons.medical_services_outlined, center.specialties),
            const SizedBox(height: 8),
            _infoRow(Icons.apartment_rounded, center.area),
            const SizedBox(height: 14),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: center.tags
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF2FD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(t, style: const TextStyle(fontSize: 12, color: C.primary)),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );

  Widget _infoRow(IconData icon, String text) => Row(
        children: [
          Icon(icon, color: C.primary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14, color: C.grey)),
          ),
        ],
      );

  // ---------------- GPS ----------------
  Widget _gpsCard(BuildContext context) => Container(
        decoration: cardDeco(r: 20),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: _point,
                      initialZoom: 15,
                      interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.doctorac.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _point,
                            width: 48,
                            height: 48,
                            child: const Icon(Icons.location_on, size: 44, color: Color(0xFFE11D48)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // طبقة شفافة: الضغط على الخريطة يفتح جوجل ماب
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _openGoogleMaps(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.location_on_outlined, center.area),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () => _openGoogleMaps(context),
                      icon: const Icon(Icons.map_outlined, size: 20),
                      label: const Text(
                        'افتح في خرائط جوجل',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: C.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}