import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color primaryColor = Color(0xFF0875E1);
  static const Color inactiveColor = Color(0xFF718096);

  static const List<IconData> icons = [
    Icons.home_rounded,
    Icons.calendar_month_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.person_outline_rounded,
  ];

  static const List<String> labels = ['الرئيسية', 'مواعيدي', 'محفظتي', 'حسابي'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5EDF5), width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: primaryColor,
            unselectedItemColor: inactiveColor,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            items: List.generate(
              icons.length,
              (index) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Icon(icons[index], size: 24),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Icon(icons[index], size: 26),
                ),
                label: labels[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
