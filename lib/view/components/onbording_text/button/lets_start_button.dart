import 'package:flutter/material.dart';
class LetsStartButton extends StatelessWidget {
  final double height;
  final String text1;
  final double width;
  final double size;
  final Color colortext;
  final Color colorCont;
  final FontWeight fontWeight;
  const LetsStartButton({
    super.key,
  required this.height,
  required this.width,
  required this.text1,
  required this.size,
  required this.fontWeight,
  required this.colortext,
  required this.colorCont,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: colorCont,
        borderRadius: BorderRadius.circular(20)
      ),child: Center(child: Text(text1,style: TextStyle(color: colortext,fontSize: size,fontWeight: fontWeight),)),
    );
  }
}
