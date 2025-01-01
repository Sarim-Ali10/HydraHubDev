import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextForm extends StatelessWidget {

  String hinttext;
  Color? color;
  String? errormsg;
  TextEditingController? controller;
  IconButton? suffixicon;
  Icon? prefixicon;

  bool? ispassword;


  CustomTextForm({this.color, required this.hinttext, this.errormsg,  this.controller,
      this.suffixicon,  this.prefixicon, this.ispassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if(value==null||value==""){
          return errormsg;
        }
        return null;
      },
      cursorColor: Color(0xFF98BF64),
      obscureText: ispassword??false,
      style: GoogleFonts.poppins(textStyle: (TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400
      ))),
      decoration: InputDecoration(
          filled: true,
          fillColor: color,
          hintText: hinttext,
          prefixIcon: prefixicon,
          suffixIcon: suffixicon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 0.9
              ),
              borderRadius: BorderRadius.circular(21)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFF98BF64),
                  width: 0.9
              ),
              borderRadius: BorderRadius.circular(21)
          )

      ),
    );
  }
}
