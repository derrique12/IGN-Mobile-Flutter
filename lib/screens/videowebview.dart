import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatefulWidget {
  const VideoWebView(
      {Key? key, required this.url, required this.number, required this.slugs})
      : super(key: key);
  final String url;
  final List<String> slugs;
  final int number;
  @override
  State<VideoWebView> createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  Color primary = const Color(0xFFC02E21);

  late List<String> slugs = [];
  @override
  void initState() {
    super.initState();
    slugs = widget.slugs;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    PageController controller = PageController(initialPage: widget.number);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: PageView.builder(
            controller: controller,
            itemCount: slugs.length,
            itemBuilder: (context, index) {
              return WebView(
                initialUrl: 'ign.com/videos/${slugs[index]}',
              );
            },
          ),
        ),
      ),
    );
  }
}
