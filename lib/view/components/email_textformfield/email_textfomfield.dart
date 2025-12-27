import 'package:flutter/material.dart';
class EmailTextfomfield extends StatelessWidget {
  final TextEditingController controller;
  final String fieldtext;
  final double height;
  final double width;
  const EmailTextfomfield({
    super.key,
  this.height=50,
  this.width=300,
    required this.fieldtext,
    required this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 0.3)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: fieldtext,
            border: InputBorder.none,

          ),
        ),
      ),
    );
  }
}
