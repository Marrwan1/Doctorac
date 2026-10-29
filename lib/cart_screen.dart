import 'package:flutter/material.dart';

import 'product_details_screen.dart';
import 'protuct_listing_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const _icons = 'assets/product-details-screen/icons/';
  static const double _deliveryFee = 30;
  static const double _freeDeliveryFrom = 500;

  final _couponCtrl = TextEditingController();
  double _discountPercent = 0; // 0.1 = 10%
  String? _couponMsg;
  bool _couponOk = false;
  int _payment = 0; // 0 كاش، 1 محفظة

  @override
  void dispose() {
    _couponCtrl.dispose();
    super.dispose();
  }

  double get _subtotal => CartStore.total;
  double get _discount => _subtotal * _discountPercent;
  double get _delivery => (_subtotal == 0 || _subtotal >= _freeDeliveryFrom) ? 0 : _deliveryFee;
  double get _grandTotal => _subtotal - _discount + _delivery;

  void _applyCoupon() {
    final code = _couponCtrl.text.trim().toUpperCase();
    setState(() {
      if (code == 'VIT10') {
        _discountPercent = 0.10;
        _couponOk = true;
        _couponMsg = 'تم تطبيق خصم 10%';
      } else {
        _discountPercent = 0;
        _couponOk = false;
        _couponMsg = 'كود الخصم غير صحيح';
      }
    });
  }

  void _checkout() {
    final total = _grandTotal;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              svgIcon('${_icons}check-circle.svg', size: 64, color: kPrimary),
              const SizedBox(height: 14),
              const Text('تم تأكيد طلبك',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(height: 6),
              Text('إجمالي الطلب ${fmtPrice(total)}',
                  style: const TextStyle(color: kGrey)),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  CartStore.items.value = {};
                  Navigator.pop(ctx); // dialog
                  Navigator.popUntil(context, (r) => r.isFirst); // للقائمة الرئيسية
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('تم'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBg,
        body: SafeArea(
          bottom: false,
          child: ValueListenableBuilder<Map<String, int>>(
            valueListenable: CartStore.items,
            builder: (context, items, _) {
              final entries = items.entries.toList();
              return Column(
                children: [
                  _header(entries.length),
                  Expanded(
                    child: entries.isEmpty
                        ? _empty()
                        : ListView(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            children: [
                              ...entries.map(_itemCard),
                              const SizedBox(height: 6),
                              _coupon(),
                              const SizedBox(height: 14),
                              _paymentMethod(),
                              const SizedBox(height: 14),
                              _summary(),
                            ],
                          ),
                  ),
                  if (entries.isNotEmpty) _checkoutBar(),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }

  // ── Header
  Widget _header(int count) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(context),
              child: svgIcon('${_icons}arrow-left.svg', size: 24, color: kDark),
            ),
            Expanded(
              child: Text(
                count == 0 ? 'سلة المشتريات' : 'سلة المشتريات ($count)',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDark),
              ),
            ),
            count == 0
                ? const SizedBox(width: 24)
                : InkWell(
                    onTap: _confirmClear,
                    child: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent),
                  ),
          ],
        ),
      );

  void _confirmClear() {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('تفريغ السلة؟'),
          content: const Text('سيتم حذف جميع المنتجات من السلة.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
            TextButton(
              onPressed: () {
                CartStore.items.value = {};
                Navigator.pop(ctx);
              },
              child: const Text('حذف الكل', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty
  Widget _empty() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(color: Color(0xFFE8F1FF), shape: BoxShape.circle),
              child: Center(child: svgIcon('${_icons}cart.svg', size: 48, color: kPrimary)),
            ),
            const SizedBox(height: 18),
            const Text('سلتك فارغة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDark)),
            const SizedBox(height: 6),
            const Text('أضف بعض المنتجات لتبدأ التسوق', style: TextStyle(color: kGrey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.maybePop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('تصفح المنتجات'),
            ),
          ],
        ),
      );

  // ── Item card (swipe للحذف + stepper)
  Widget _itemCard(MapEntry<String, int> e) {
    final p = allProducts.firstWhere((x) => x.id == e.key);
    return Dismissible(
      key: ValueKey(p.id),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => CartStore.setQty(p.id, 0),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p)),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: kPrimary.withOpacity(.07), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 90,
                decoration: BoxDecoration(color: const Color(0xFFEFF5FF), borderRadius: BorderRadius.circular(14)),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(p.image, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
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
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kDark)),
                        ),
                        InkWell(
                          onTap: () => CartStore.setQty(p.id, 0),
                          child: svgIcon('${_icons}close-circle.svg', size: 20, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(p.tag, style: const TextStyle(fontSize: 12, color: kGrey)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(fmtPrice(p.price * e.value),
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kPrimary)),
                        ),
                        QtyStepper(
                          qty: e.value,
                          onMinus: () => CartStore.setQty(p.id, e.value - 1),
                          onPlus: () => CartStore.setQty(p.id, e.value + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Coupon
  Widget _coupon() => Container(
        padding: const EdgeInsets.all(14),
        decoration: _box(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('كود الخصم', style: TextStyle(fontWeight: FontWeight.bold, color: kDark)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponCtrl,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'أدخل الكود (جرّب VIT10)',
                      hintStyle: const TextStyle(color: kGrey, fontSize: 13),
                      filled: true,
                      fillColor: kBg,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _applyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('تطبيق'),
                ),
              ],
            ),
            if (_couponMsg != null) ...[
              const SizedBox(height: 8),
              Text(_couponMsg!,
                  style: TextStyle(fontSize: 12, color: _couponOk ? Colors.green.shade700 : Colors.redAccent)),
            ],
          ],
        ),
      );

  // ── Payment
  Widget _paymentMethod() {
    Widget option(int i, String label, Widget icon) {
      final sel = _payment == i;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _payment = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: sel ? const Color(0xFFE8F1FF) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: sel ? kPrimary : Colors.blue.shade100, width: sel ? 1.5 : 1),
            ),
            child: Column(
              children: [
                icon,
                const SizedBox(height: 6),
                Text(label,
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, color: sel ? kPrimary : kDark)),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('طريقة الدفع', style: TextStyle(fontWeight: FontWeight.bold, color: kDark)),
          const SizedBox(height: 10),
          Row(
            children: [
              option(0, 'كاش عند الاستلام', const Icon(Icons.payments_outlined, color: kPrimary)),
              const SizedBox(width: 10),
              option(1, 'المحفظة', svgIcon('${_icons}wallet.svg', size: 24, color: kPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Summary
  Widget _summary() {
    Widget row(String l, String v, {bool bold = false, Color? color}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Text(l, style: TextStyle(color: bold ? kDark : kGrey, fontWeight: bold ? FontWeight.bold : null)),
              const Spacer(),
              Text(v,
                  style: TextStyle(
                      fontWeight: bold ? FontWeight.bold : FontWeight.w600,
                      fontSize: bold ? 17 : 14,
                      color: color ?? (bold ? kPrimary : kDark))),
            ],
          ),
        );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _box(),
      child: Column(
        children: [
          row('المجموع الفرعي', fmtPrice(_subtotal)),
          if (_discount > 0) row('الخصم', '- ${fmtPrice(_discount)}', color: Colors.green.shade700),
          row('التوصيل', _delivery == 0 ? 'مجاني' : fmtPrice(_delivery)),
          if (_delivery > 0)
            Align(
              alignment: Alignment.centerRight,
              child: Text('أضف ${fmtPrice(_freeDeliveryFrom - _subtotal)} للحصول على توصيل مجاني',
                  style: const TextStyle(fontSize: 11, color: kGrey)),
            ),
          const Divider(height: 22),
          row('الإجمالي', fmtPrice(_grandTotal), bold: true),
        ],
      ),
    );
  }

  Widget _checkoutBar() => Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: kPrimary.withOpacity(.08), blurRadius: 12, offset: const Offset(0, -4)),
        ]),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _checkout,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            child: Text('تأكيد الطلب  •  ${fmtPrice(_grandTotal)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      );

  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: kPrimary.withOpacity(.07), blurRadius: 12, offset: const Offset(0, 4))],
      );
}
