import 'package:flutter/material.dart';

class HSpacer extends StatelessWidget {
  final double width;
  const HSpacer(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class VSpacer extends StatelessWidget {
  final double height;
  const VSpacer(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
