import 'package:flutter/material.dart';

class ListLabel extends StatelessWidget {
  final String text;
  const ListLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: const TextStyle(
          letterSpacing: .8,
          fontSize: 20,
          color: Color(0xff252525),
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
        ),
      ),
    );
  }
}
