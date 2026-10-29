import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'protuct_listing_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  static const _icons = 'assets/product-details-screen/icons/';

  final _pageController = PageController();
  int _page = 0;
  int _qty = 1;

  Product get p => widget.product;

  // صور الكاروسيل: صورة المنتج + صورة التفاصيل
  List<String> get _images => [
        p.image,
        'assets/product-details-screen/images/vitamins.jpeg',
        p.image,
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addToCart() {
    CartStore.add(p.id, _qty);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: kDark,
        content: Text('تمت إضافة $_qty × ${p.name} إلى السلة'),
        action: SnackBarAction(
          label: 'عرض السلة',
          textColor: Colors.white,
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const CartScreen())),
        ),
      ));
    setState(() => _qty = 1);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            children: [
              _topBar(),
              const SizedBox(height: 8),
              _carousel(),
              const SizedBox(height: 18),
              Text(p.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(height: 4),
              Text(p.subtitle, style: const TextStyle(fontSize: 15, color: kGrey)),
              const SizedBox(height: 10),
              _rating(),
              const SizedBox(height: 12),
              _tags(),
              const SizedBox(height: 14),
              Text('من ${fmtPrice(p.price)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kDark)),
              const Divider(height: 28),
              const Text('الكمية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(height: 8),
              _qtyBox(),
              const SizedBox(height: 14),
              _addButton(),
              const SizedBox(height: 16),
              _features(),
              const SizedBox(height: 18),
              const Text('وصف المنتج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(height: 8),
              Text(p.description, style: const TextStyle(fontSize: 14, color: kGrey, height: 1.7)),
              const SizedBox(height: 14),
              _ingredients(),
            ],
          ),
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }

  // ── Top bar
  Widget _topBar() => Row(
        children: [
          InkWell(
            onTap: () => Navigator.maybePop(context),
            child: svgIcon('${_icons}arrow-left.svg', size: 24, color: kDark),
          ),
          const Spacer(),
          ValueListenableBuilder<Set<String>>(
            valueListenable: CartStore.favorites,
            builder: (_, favs, __) => InkWell(
              onTap: () => CartStore.toggleFav(p.id),
              child: svgIcon('${_icons}heart.svg',
                  size: 24, color: favs.contains(p.id) ? Colors.red : kDark),
            ),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CartScreen())),
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
      );

  // ── Image carousel
  Widget _carousel() => Column(
        children: [
          Hero(
            tag: 'product-${p.id}',
            child: Container(
              height: 280,
              decoration: BoxDecoration(color: const Color(0xFFEAF3FF), borderRadius: BorderRadius.circular(24)),
              clipBehavior: Clip.antiAlias,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => Image.asset(_images[i], fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _images.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _page ? 16 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: i == _page ? kPrimary : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _rating() => Row(
        children: [
          svgIcon('${_icons}star.svg', size: 18, color: const Color(0xFFFFB400)),
          const SizedBox(width: 5),
          Text('${p.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(width: 5),
          Text('(${p.reviews} تقييم)', style: const TextStyle(color: kGrey, fontSize: 13)),
        ],
      );

  Widget _tags() {
    Widget chip(String t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFE8F1FF), borderRadius: BorderRadius.circular(12)),
          child: Text(t, style: const TextStyle(color: kDark, fontSize: 13)),
        );
    return Wrap(spacing: 8, children: [chip(p.tag), if (p.category != p.tag) chip(p.category)]);
  }

  // ── Quantity
  Widget _qtyBox() {
    Widget btn(IconData i, VoidCallback f) => InkWell(
          onTap: f,
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(color: Color(0xFFE8F1FF), shape: BoxShape.circle),
            child: Icon(i, size: 20, color: kPrimary),
          ),
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          btn(Icons.add, () => setState(() => _qty++)),
          Text('$_qty', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          btn(Icons.remove, () => setState(() => _qty = _qty > 1 ? _qty - 1 : 1)),
        ],
      ),
    );
  }

  Widget _addButton() => SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton.icon(
          onPressed: _addToCart,
          icon: svgIcon('${_icons}cart.svg', size: 20, color: Colors.white),
          label: Text('أضف للسلة  •  ${fmtPrice(p.price * _qty)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
          ),
        ),
      );

  // ── Features
  Widget _features() {
    Widget item(String icon, String t1, String t2) => Expanded(
          child: Column(
            children: [
              svgIcon('$_icons$icon', size: 30, color: kPrimary),
              const SizedBox(height: 6),
              Text(t1, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              Text(t2, textAlign: TextAlign.center, style: const TextStyle(color: kGrey, fontSize: 11)),
            ],
          ),
        );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade50),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            item('protection.svg', 'التوصيل', 'لجميع المناطق'),
            VerticalDivider(color: Colors.blue.shade50),
            item('check-circle.svg', 'متوفر', 'في المخزون'),
            VerticalDivider(color: Colors.blue.shade50),
            item('badge-check.svg', 'منتج أصلي', '100%'),
          ],
        ),
      ),
    );
  }

  // ── Ingredients (expandable)
  Widget _ingredients() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text('المكونات', style: TextStyle(fontWeight: FontWeight.bold, color: kDark)),
            trailing: svgIcon('${_icons}chevron-down.svg', size: 20, color: kDark),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: p.ingredients
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 7, color: kPrimary),
                          const SizedBox(width: 8),
                          Text(e, style: const TextStyle(color: kGrey)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
}
