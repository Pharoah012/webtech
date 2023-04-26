import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webtech_project/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isbold;
  final double fontSize;
  final Color color;
  final bool isMediumWeight;
  

  const CustomText({super.key,
    required this.text,
    this.isMediumWeight = false,
    this.isbold = false,
    this.fontSize = 14,
    this.color = kBlack

  });

  @override
  Widget build(BuildContext context) {
    FontWeight weight(){
      if(isMediumWeight){
        return FontWeight.w500;
      }
      else if (isbold){
      return FontWeight.w800;
      }
      else{
       return FontWeight.normal;

      }
    }
    return Text(
      text,
      style: GoogleFonts.manrope(
        fontWeight: weight(),
        fontSize: fontSize,
        color: color
         
      ),);
  }
}