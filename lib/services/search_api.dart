import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../search_results_screen.dart';

class SearchApi {
  static const _base = 'https://6ae7235156b2ee1e54402210.mockapi.io';

  static List<SearchDoctor>? _doctorsCache;
  static List<(String, String)>? _specialtiesCache;

  static String _s(Map j, String k) => (j[k] ?? '').toString();
  static num _n(Map j, String k) => num.tryParse((j[k] ?? 0).toString()) ?? 0;

  static SearchDoctor _doctorFromJson(Map j) => SearchDoctor(
    title: _s(j, 'title'),
    name: _s(j, 'name'),
    specialty: _s(j, 'specialty'),
    fullTitle: _s(j, 'fullTitle'),
    area: _s(j, 'area'),
    city: _s(j, 'city'),
    center: _s(j, 'center'),
    centerType: _s(j, 'centerType'),
    clinic: _s(j, 'clinic'),
    image: _s(j, 'image'),
    rating: _n(j, 'rating').toDouble(),
    reviews: _n(j, 'reviews').toInt(),
    price: _n(j, 'price').toInt(),
    wait: _n(j, 'wait').toInt(),
  );

  static Future<List> _get(String path) async {
    final res = await http
        .get(Uri.parse('$_base/$path'))
        .timeout(const Duration(seconds: 8));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
    return jsonDecode(utf8.decode(res.bodyBytes)) as List;
  }

  /// الدكاترة من الـ API، ولو فشل يرجع البيانات المحلية.
  static Future<List<SearchDoctor>> fetchDoctors() async {
    if (_doctorsCache != null) return _doctorsCache!;
    try {
      final data = await _get('doctors');
      final list = data.map((e) => _doctorFromJson(e as Map)).toList();
      if (list.isEmpty) return searchDoctors;
      _doctorsCache = list;
      return list;
    } catch (e) {
      debugPrint('SearchApi.fetchDoctors failed: $e');
      return searchDoctors;
    }
  }

  /// التخصصات (الاسم، اسم الأيقونة) من الـ API، ولو فشل يرجع [fallback].
  static Future<List<(String, String)>> fetchSpecialties(
    List<(String, String)> fallback,
  ) async {
    if (_specialtiesCache != null) return _specialtiesCache!;
    try {
      final data = await _get('specialties');
      final list = data
          .map((e) => (_s(e as Map, 'name'), _s(e, 'icon')))
          .toList();
      if (list.isEmpty) return fallback;
      _specialtiesCache = list;
      return list;
    } catch (e) {
      debugPrint('SearchApi.fetchSpecialties failed: $e');
      return fallback;
    }
  }
}
