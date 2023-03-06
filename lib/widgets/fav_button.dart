import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final bool isFav;
  final void toggleFav;
  const FavButton({super.key, required this.isFav, required this.toggleFav});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => toggleFav,
      icon: Icon(
        isFav ? Icons.star : Icons.star_border_sharp,
        color: isFav ? Colors.white : Colors.white,
        size: 30,
      ),
    );
  }
}
