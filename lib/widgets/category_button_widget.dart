import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  const CategoryButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        foregroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        side: BorderSide(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
