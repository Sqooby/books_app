import 'package:books_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReaderScreen extends StatefulWidget {
  static String routeName = '/reader';

  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://www.google.pl'),
      );
  }

  Widget build(BuildContext context) {
    final String html = ModalRoute.of(context)?.settings.arguments as String;
    print(html);
    return Scaffold(
        body: WebViewWidget(
      controller: controller,
    ));
  }
}
