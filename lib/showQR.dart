import 'package:flutter/material.dart';

class showQR extends StatelessWidget {
  final String mediaURL;
  showQR({this.mediaURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DISPLAY QR"),
      ),
      body: Center(child: Image.network(this.mediaURL)),
    );
  }
}
