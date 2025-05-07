import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.black54,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: onTap ?? (index) {
        // Default navigation logic — update these routes as needed
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/dashboard');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/auto-finance');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/stocklist');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/loan-confirmation');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/more');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Auto-Finance Request'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Stocklist'),
        BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Loan Confirmation'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}
