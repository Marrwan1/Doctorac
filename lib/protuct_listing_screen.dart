import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cart_screen.dart';
import 'product_details_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';

// ───────────────────────── Colors ─────────────────────────
const kPrimary = Color(0xFF0B63CE);
const kDark = Color(0xFF0A3D91);
const kBg = Color(0xFFF4F8FF);
const kGrey = Color(0xFF6B7A90);

// ───────────────────────── Model ─────────────────────────
class Product {
  final String id;
  final String name;
  final String subtitle;
  final String tag; // التاج اللي بيظهر على الكارت
  final String category; // الفلتر: فيتامينات / مكملات عامة / مناعة
  final double price;
  final double rating;
  final int reviews;
  final String image;
  final String description;
  final List<String> ingredients;

  const Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.tag,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.description,
    required this.ingredients,
  });
}

const _img = 'assets/product-listing-screen/images/';

const List<Product> allProducts = [
  Product(
    id: 'p1',
    name: 'Vitamin D3 1000 IU',
    subtitle: 'Supports bone & immune health',
    tag: 'فيتامينات',
    category: 'فيتامينات',
    price: 180,
    rating: 4.8,
    reviews: 320,
    image: '${_img}vitamins-00.jpeg',
    description:
        'مكمل غذائي يدعم صحة العظام والمناعة ويساعد الجسم على امتصاص الكالسيوم.',
    ingredients: ['فيتامين D3 (1000 وحدة دولية)', 'زيت الزيتون', 'جيلاتين'],
  ),
  Product(
    id: 'p2',
    name: 'Omega 3 Fish Oil',
    subtitle: 'يدعم صحة القلب والدماغ',
    tag: 'مكملات أوميجا',
    category: 'مكملات عامة',
    price: 320,
    rating: 4.7,
    reviews: 210,
    image: '${_img}vitamins-01.jpeg',
    description:
        'زيت سمك غني بأحماض أوميجا 3 الدهنية، يدعم صحة القلب والدماغ والنظر.',
    ingredients: ['EPA 360 mg', 'DHA 240 mg', 'فيتامين E'],
  ),
  Product(
    id: 'p3',
    name: 'Multivitamin For Men',
    subtitle: 'يدعم الطاقة والمناعة',
    tag: 'فيتامينات',
    category: 'مناعة',
    price: 275,
    rating: 4.6,
    reviews: 180,
    image: '${_img}vitamins-02.jpeg',
    description:
        'فيتامينات ومعادن متكاملة مصممة لاحتياجات الرجال لدعم الطاقة والمناعة.',
    ingredients: ['فيتامين C', 'فيتامين B12', 'زنك', 'ماغنسيوم'],
  ),
  Product(
    id: 'p4',
    name: 'Calcium + D3',
    subtitle: 'يقوي العظام والأسنان',
    tag: 'معادن',
    category: 'مكملات عامة',
    price: 210,
    rating: 4.5,
    reviews: 145,
    image: '${_img}vitamins-03.jpeg',
    description: 'كالسيوم مع فيتامين D3 لتقوية العظام والأسنان وتقليل خطر الهشاشة.',
    ingredients: ['كالسيوم 600 mg', 'فيتامين D3', 'ماغنسيوم'],
  ),
  Product(
    id: 'p5',
    name: 'Centrum Men 50+',
    subtitle: 'مكمل غذائي شامل للرجال فوق 50 سنة',
    tag: 'مكملات عامة',
    category: 'مكملات عامة',
    price: 520,
    rating: 4.8,
    reviews: 320,
    image: '${_img}vitamins-04.jpg',
    description:
        'مكمل غذائي شامل يحتوي على الفيتامينات والمعادن الأساسية التي تساعد على دعم الطاقة، المناعة، صحة القلب والعظام، بشكل خاص للرجال فوق سن 50.',
    ingredients: ['فيتامين A', 'فيتامين C', 'فيتامين D', 'فيتامين B12', 'زنك', 'سيلينيوم'],
  ),
  Product(
    id: 'p6',
    name: 'Vitamin C 1000 mg',
    subtitle: 'يقوي المناعة ويحارب الإرهاق',
    tag: 'فيتامينات',
    category: 'مناعة',
    price: 150,
    rating: 4.4,
    reviews: 98,
    image: '${_img}vitamins-05.jpeg',
    description: 'فيتامين C بتركيز عالٍ لدعم المناعة وحماية الخلايا من الأكسدة.',
    ingredients: ['فيتامين C 1000 mg', 'بيوفلافونويد'],
  ),
];

// ───────────────────────── Cart / Favorites store ─────────────────────────
class CartStore {
  static final ValueNotifier<Map<String, int>> items = ValueNotifier({});
  static final ValueNotifier<Set<String>> favorites = ValueNotifier({});

  static int qty(String id) => items.value[id] ?? 0;

  static void setQty(String id, int q) {
    final m = Map<String, int>.from(items.value);
    if (q <= 0) {
      m.remove(id);
    } else {
      m[id] = q;
    }
    items.value = m;
  }

  static void add(String id, [int by = 1]) => setQty(id, qty(id) + by);

  static int get count => items.value.values.fold(0, (a, b) => a + b);

  static double get total => items.value.entries.fold(0.0, (sum, e) {
        final p = allProducts.firstWhere((p) => p.id == e.key);
        return sum + p.price * e.value;
      });

  static void toggleFav(String id) {
    final s = Set<String>.from(favorites.value);
    s.contains(id) ? s.remove(id) : s.add(id);
    favorites.value = s;
  }
}

String fmtPrice(double v) => '${v.toStringAsFixed(v % 1 == 0 ? 0 : 2)} جنيه';

Widget svgIcon(String path, {double size = 20, Color? color}) => SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );

// ───────────────────────── Screen ─────────────────────────
class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  static const _icons = 'assets/product-listing-screen/icons/';
  static const _filters = ['الكل', 'فيتامينات', 'مكملات عامة', 'مناعة'];

  String _query = '';
  String _filter = 'الكل';

  List<Product> get _visible {
    final q = _query.trim().toLowerCase();
    return allProducts.where((p) {
      final okFilter = _filter == 'الكل' || p.category == _filter || p.tag == _filter;
      final okSearch = q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.subtitle.toLowerCase().contains(q) ||
          p.tag.contains(q);
      return okFilter && okSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _visible;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBg,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _header(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  children: [
                    _searchBar(),
                    const SizedBox(height: 14),
                    _banner(),
                    const SizedBox(height: 14),
                    _filterChips(),
                    const SizedBox(height: 14),
                    if (products.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text('لا توجد منتجات مطابقة', style: TextStyle(color: kGrey, fontSize: 15)),
                        ),
                      )
                    else
                      ...products.map(_productCard),
                  ],
                ),
              ),
              _cartBar(),
            ],
          ),
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }

  // ── Header
  Widget _header() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(context),
              child: svgIcon('${_icons}arrow-right.svg', size: 24, color: kDark),
            ),
            const Expanded(
              child: Text(
                'الفيتامينات والمكملات الغذائية',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDark),
              ),
            ),
            InkWell(
              onTap: _openCartSheet,
              child: ValueListenableBuilder<Map<String, int>>(
                valueListenable: CartStore.items,
                builder: (_, __, ___) => Badge(
                  isLabelVisible: CartStore.count > 0,
                  label: Text('${CartStore.count}'),
                  child: svgIcon('${_icons}cart.svg', size: 24, color: kDark),
                ),
              ),
            ),
          ],
        ),
      );

  // ── Search
  Widget _searchBar() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: kPrimary.withOpacity(.06), blurRadius: 10)],
        ),
        child: TextField(
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'ابحث عن منتج أو ماركة...',
            hintStyle: const TextStyle(color: kGrey, fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: svgIcon('${_icons}search.svg', size: 20, color: kGrey),
            ),
          ),
        ),
      );

  // ── Banner
  Widget _banner() => Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [Color(0xFFDCEBFF), Color(0xFFEAF3FF)]),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            const Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مكملاتك الغذائية\nلحياة أفضل',
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: kDark, height: 1.3)),
                    SizedBox(height: 6),
                    Text('قوتك .. صحتك .. طاقتك', style: TextStyle(fontSize: 12, color: kGrey)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset('${_img}product-listing-screen-image.jpeg', fit: BoxFit.cover, height: double.infinity),
            ),
          ],
        ),
      );

  // ── Filters
  Widget _filterChips() => SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, i) {
            final f = _filters[i];
            final selected = f == _filter;
            return GestureDetector(
              onTap: () => setState(() => _filter = f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? kPrimary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: kPrimary.withOpacity(.08), blurRadius: 8)],
                ),
                child: Text(f,
                    style: TextStyle(
                        color: selected ? Colors.white : kDark, fontWeight: FontWeight.w600, fontSize: 14)),
              ),
            );
          },
        ),
      );

  // ── Product card
  Widget _productCard(Product p) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p)),
      ).then((_) => setState(() {})),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: kPrimary.withOpacity(.07), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
                      ),
                      ValueListenableBuilder<Set<String>>(
                        valueListenable: CartStore.favorites,
                        builder: (_, favs, __) {
                          final fav = favs.contains(p.id);
                          return InkWell(
                            onTap: () => CartStore.toggleFav(p.id),
                            child: svgIcon('${_icons}heart.svg',
                                size: 22, color: fav ? Colors.red : Colors.grey.shade400),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(p.subtitle,
                      maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: kGrey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFE8F1FF), borderRadius: BorderRadius.circular(10)),
                        child: Text(p.tag, style: const TextStyle(fontSize: 11, color: kDark)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      svgIcon('${_icons}star.svg', size: 16, color: const Color(0xFFFFB400)),
                      const SizedBox(width: 4),
                      Text('${p.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 4),
                      Text('(${p.reviews})', style: const TextStyle(color: kGrey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text('من ${fmtPrice(p.price)}',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kPrimary)),
                      ),
                      _addOrStepper(p),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Hero(
              tag: 'product-${p.id}',
              child: Container(
                width: 92,
                height: 112,
                decoration: BoxDecoration(color: const Color(0xFFEFF5FF), borderRadius: BorderRadius.circular(16)),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(p.image, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addOrStepper(Product p) {
    return ValueListenableBuilder<Map<String, int>>(
      valueListenable: CartStore.items,
      builder: (_, __, ___) {
        final q = CartStore.qty(p.id);
        if (q == 0) {
          return ElevatedButton.icon(
            onPressed: () => CartStore.add(p.id),
            icon: svgIcon('${_icons}cart.svg', size: 16, color: Colors.white),
            label: const Text('أضف للسلة', style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          );
        }
        return QtyStepper(
          qty: q,
          onMinus: () => CartStore.setQty(p.id, q - 1),
          onPlus: () => CartStore.setQty(p.id, q + 1),
        );
      },
    );
  }

  // ── Cart summary bar
  Widget _cartBar() => ValueListenableBuilder<Map<String, int>>(
        valueListenable: CartStore.items,
        builder: (_, __, ___) {
          if (CartStore.count == 0) return const SizedBox.shrink();
          return GestureDetector(
            onTap: _openCartSheet,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  svgIcon('${_icons}cart.svg', size: 20, color: Colors.white),
                  const SizedBox(width: 10),
                  Text('عرض السلة (${CartStore.count})',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(fmtPrice(CartStore.total),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      );

  // ── فتح صفحة السلة
  void _openCartSheet() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
  }
}

// ───────────────────────── Shared widgets ─────────────────────────
class QtyStepper extends StatelessWidget {
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const QtyStepper({super.key, required this.qty, required this.onMinus, required this.onPlus});

  @override
  Widget build(BuildContext context) {
    Widget btn(IconData i, VoidCallback f) => InkWell(
          onTap: f,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(color: Color(0xFFE8F1FF), shape: BoxShape.circle),
            child: Icon(i, size: 16, color: kPrimary),
          ),
        );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        btn(Icons.add, onPlus),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ),
        btn(Icons.remove, onMinus),
      ],
    );
  }
}

/// غلاف حول الـ nav bar بتاعك. لو اسم الـ widget أو الـ parameters مختلفة عدّل هنا بس.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(
      currentIndex: currentIndex,
      onTap: (i) {
        // اربط هنا باقي الصفحات: 0 الرئيسية، 1 مواعيدي، 2 محفظتي، 3 حسابي
        if (i == 0) Navigator.popUntil(context, (r) => r.isFirst);
      },
    );
  }
}
