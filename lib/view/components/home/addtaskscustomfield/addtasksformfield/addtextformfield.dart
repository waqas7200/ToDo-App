import 'package:flutter/material.dart';
class Addtextformfield extends StatelessWidget {
  final TextEditingController controller;
  final String fieldtext;
  final double height;
  final double width;
  final IconData? icon;
  final IconData? suficon;
  final FontWeight fontWeight;
  final Color containercolor;
  const Addtextformfield({super.key,
    this.containercolor=Colors.lightBlueAccent,
    this.height=50,
    this.icon,
    this.suficon,
    this.fontWeight=FontWeight.normal,
    this.width=300,
    required this.fieldtext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: containercolor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType:TextInputType.multiline,
          maxLines: null,
          minLines: 1,
          controller: controller,
          decoration: InputDecoration(
              hintText: fieldtext,
              hintStyle: TextStyle(fontWeight: fontWeight),
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              suffixIcon: Icon(suficon)
          ),
        ),
      ),
    );;
  }
}
