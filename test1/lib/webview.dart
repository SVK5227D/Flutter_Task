import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// ignore_for_file: unused_field

class SamplePageFour extends StatefulWidget {
  const SamplePageFour({super.key});

  @override
  State<SamplePageFour> createState() => _SamplePageFourState();
}

class _SamplePageFourState extends State<SamplePageFour> {
  double _processBar = 0;

  late InAppWebViewController inAppWebViewController;

  _goBack() async {
    if (await inAppWebViewController.canGoBack()) {
      await inAppWebViewController.goBack();
    }
  }

  _goForward() async {
    if (await inAppWebViewController.canGoForward()) {
      await inAppWebViewController.goForward();
    }
  }

  // _goEighter() async{
  //   if(await inAppWebViewController.){

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(onPressed: _goBack, icon: const Icon(Icons.arrow_back)),
        //     IconButton(
        //         onPressed: _goForward, icon: const Icon(Icons.arrow_forward)),
        //   ],
        // ),
        body: SafeArea(
          child: InAppWebView(
            // Initial url
            initialUrlRequest:
                URLRequest(url: Uri.parse('https://www.w3schools.com/')),
            // To control back and forward of the web
            onWebViewCreated: (InAppWebViewController controller) {
              inAppWebViewController = controller;
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                _processBar = progress / 100;
              });
            },
          ),
        ),
      ),
    );
  }
}
