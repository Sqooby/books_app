import 'package:books_app/screens/reader_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../generated/l10n.dart';

class MoreContext extends StatelessWidget {
  final String fragment;
  final String href;
  final String pdf;
  const MoreContext(
      {super.key,
      required this.fragment,
      required this.href,
      required this.pdf});

  Future<void> _launchUrl() async {
    final url = Uri.tryParse(href);

    if (url != null && await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: HtmlWidget(
              fragment,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: _launchUrl,
                child: Text(
                  S.of(context).seemore,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
