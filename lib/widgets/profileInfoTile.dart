import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/widgets/customText.dart';

class CustomProfileInfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomProfileInfoTile({
    super.key,
    required this.subtitle,
    required this.title
    });

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 12,
          color: kGrey,
          isMediumWeight: true,
        ),
       const SizedBox(height: 2,),
        CustomText(
          fontSize: 14,
          isMediumWeight: true,
          text: subtitle
          ),
       const SizedBox(height: 10,),

      ],
    );
  }
}