import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  Color? color = const Color(0xFFC3C3C3);

  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: -15,
              blurRadius: 20,
              color: Color.fromRGBO(18, 1, 1, 1),
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          unselectedItemColor: color,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          elevation: 30,

          // fixedColor: color,
          showUnselectedLabels: true,
          unselectedFontSize: 14,
          selectedFontSize: 14,
          selectedLabelStyle: const TextStyle(
              fontFamily: 'Raleway', fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(
              fontFamily: 'Raleway', fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined),
              label: 'Libary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
