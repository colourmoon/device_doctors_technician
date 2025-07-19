import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class DeshBordHome extends StatefulWidget {
  const DeshBordHome({super.key});

  @override
  State<DeshBordHome> createState() => _DeshBordHomeState();
}

class _DeshBordHomeState extends State<DeshBordHome> {
  final DonationRepository repository = DonationRepository();
  late StreamController<Response> _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<Response>();
    _initiateDonation(); // Trigger on start
  }

  void _initiateDonation() {
    repository.initiateDonation().listen(
      (response) {
        _controller.add(response);
      },
      onError: (error) {
        _controller.addError(error);
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Initiate Donation')),
      body: StreamBuilder<Response>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('❌ Error occurred:\n${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _initiateDonation,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final response = snapshot.data!;
            if (response.statusCode == 200) {
              String url = response.data['url'] ?? '';
              if (url.isNotEmpty) {
              }

              return MaterialButton(onPressed: () {

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => WebViewScreen(url: url),
                    ),
                  ).then((_) {
                    // 🌟 Reset the stream and reload data when WebView is closed
                    _initiateDonation();
                  });
                });
              },color: Colors.black,child: const Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('⚠️ Failed: ${response.statusMessage}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _initiateDonation,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
          } else {
            return const Center(child: Text('🔍 No data'));
          }
        },
      ),
    );
  }
}

class DonationRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://ramanarayanam.org/api/"));

  Stream<Response> initiateDonation() async* {
    const String endpoint = "donations/initiate_donation";

    final formData = FormData.fromMap({
      "access_token": "RN91141768173",
      "donation_purpose": "4",
      "donation_type": "2",
      "occation": "Birthday",
      "date": "25-10-2024",
      "donar_name": "Ramu",
      "phone_number": "7993097321",
      "address": "dwrakanagar,visakapatnam",
      "gothram": "ragukula gothram",
      "tidhi": "test",
      "nakshtram": "tesst",
      "masam": "test",
      "pancard_number": "Borpa19990",
      "aadhar_card_number": "98765432123",
      "pincode": "530024",
      "amount": "1000",
    });

    yield* Stream.fromFuture(_dio.post(endpoint, data: formData));
  }
}
class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Gateway")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, url) {
          if (url.toString().contains("success")) {
            Navigator.pop(context); // Close WebView
            // _confirmPaymentStatus(); // Trigger confirm API
          }
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final uri = navigationAction.request.url;

          if (uri == null) return NavigationActionPolicy.ALLOW;
          if (uri.scheme == "intent" || uri.scheme == "upi") {
            try {
              final intentUrl = uri.toString();
              if (await canLaunchUrl(Uri.parse(intentUrl))) {
                await launchUrl(Uri.parse(intentUrl), mode: LaunchMode.externalApplication);
              } else {
                debugPrint("Cannot launch UPI intent URL");
              }
              return NavigationActionPolicy.CANCEL;
            } catch (e) {
              debugPrint("Error launching intent: $e");
              return NavigationActionPolicy.CANCEL;
            }
          }

          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}