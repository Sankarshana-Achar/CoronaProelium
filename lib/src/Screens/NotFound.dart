import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text(
          "Apologies. We don't have resources in the requested region",
        ),
      ),
    );
  }
}
