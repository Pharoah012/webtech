import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';

class CustomLoader extends StatelessWidget {

 const CustomLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: kPrimary,
            ),
          ),
        ],
      )
    );
  }
}
