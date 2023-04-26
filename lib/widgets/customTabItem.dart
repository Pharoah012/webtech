import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/widgets/customText.dart';


class CustomTabItem extends StatelessWidget {
  final VoidCallback ontapped;
  final String text;
  final Color color;
  final Color visibleColor;
  const CustomTabItem({super.key, 
  required this.text,
  this.visibleColor = kPrimary,
  this.color = kGrey,
  required this.ontapped });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          GestureDetector(
            onTap:ontapped,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: text,
                color: color
                ),
            )),
         
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: visibleColor,
            )
          
      ],
    );
  }
}