import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/widgets/customText.dart';



class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double? width;
  final Color color;
  const CustomButton({
    super.key,
    this.width,
    this.color = kBlack,
    required this.text,
    this.height = 56.0,
    required this.onPressed
    });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: widget.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(widget.height),
            primary: widget.color
          ),
          onPressed: widget.onPressed,
          child: CustomText(
            text: widget.text,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}