import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CacheInformation extends StatelessWidget {
  final Function() onPressed;
  const CacheInformation({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.amber,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              S.of(context).cacheInfo,
              style: const TextStyle(color: Colors.white),
            ),
            MaterialButton(
              onPressed: onPressed,
              textColor: Theme.of(context).primaryColor,
              shape: const CircleBorder(),
              color: Colors.white,
              child: const Icon(Icons.wifi_off),
            )
          ],
        ),
      ),
    );
  }
}
