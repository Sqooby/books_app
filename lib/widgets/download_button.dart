import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 90,
      backgroundColor: const Color(0xFFFA8502),
      child: IconButton(
        icon: const Icon(Icons.download),
        color: Colors.white,
        onPressed: () {},
      ),
    );
  }
}
