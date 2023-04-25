import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/widgets/customText.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            //Place illustration on top
            Image.asset(
              'images/blankimage.jpg',
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width*0.4,
              ),
              const SizedBox(height: 10,),
           const  CustomText(
              text: 'Select from the menu on the left',
              fontSize: 20,
              color: kGrey,
              )
            
          ],
        ),
      ),
    );
  }
}
