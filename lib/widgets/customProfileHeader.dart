import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:webtech_project/widgets/customAppBar.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        // User preferred image should be uploaded
        // these images are just for the project
        Image.asset('images/profilebackground.jpg',
          width: MediaQuery.of(context).size.width,
         fit:BoxFit.cover ,),
      const Padding(
         padding:  EdgeInsets.all(10.0),
         child:  CircleAvatar(
          radius: 30,
            backgroundImage: AssetImage('images/profileavatar.jpg'),
          ),
       )
       
      ],
    );
  }
}