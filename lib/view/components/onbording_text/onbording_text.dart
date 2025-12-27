import 'package:flutter/material.dart';

class OnbordingText extends StatelessWidget {
  final String text1;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  const OnbordingText({
    super.key,
    required this.text1,
    required this.color,
    required this.size,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text1,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight),);
  }
}


