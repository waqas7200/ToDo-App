import 'package:flutter/material.dart';
class PasswordTexFormField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldtext;
  final double height;
  final double width;

   PasswordTexFormField({
    super.key,
    this.height=50,
    this.width=300,
    required this.fieldtext,
    required this.controller,
  });

  @override
  State<PasswordTexFormField> createState() => _PasswordTexFormFieldState();
}

class _PasswordTexFormFieldState extends State<PasswordTexFormField> {
bool isicon=true;



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.3)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          obscureText: isicon,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.fieldtext,
            border: InputBorder.none,
            suffixIcon: IconButton(onPressed: (){
              if(  isicon==true){
                isicon=false;
                setState(() {

                });
              }
              else
                {
                  isicon=true;
                  setState(() {

                  });
                }

            }, icon:  Icon(isicon==true?Icons.visibility_off:Icons.visibility))
          ),
        ),
      ),
    );;
  }
}
