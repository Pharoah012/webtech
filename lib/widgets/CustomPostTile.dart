import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'dart:math' as math;
import 'package:webtech_project/widgets/customText.dart';
import 'package:timeago/timeago.dart' as timeago;


class CustomPostTile extends StatelessWidget {
  final String message;
  final String user;
  final double timestamp;
  const CustomPostTile({
    super.key,
    required this.timestamp,
    required this.message,
    // required this.timestamp,
    required this.user
    });

    // Convert the timestamp to a DateTime object
// DateTime dateTime;
// convertTimestamp
// if (timestamp is int) {
//   // If the timestamp is in seconds
//   dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
// } else if (timestamp is double) {
//   // If the timestamp is in milliseconds
//   dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
// } else {
//   // Handle other cases
// }


  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width* 0.5,
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: user,
                color: kGrey,
                isMediumWeight: true,
                ),
              CustomText(
                text: message,
                color: kBlack
                ),
              const  SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed:null,
                     icon: Icon(Icons.favorite)), 
                    IconButton(
                    onPressed:null,
                     icon: Icon(Icons.comment)), 
                 const Spacer(),
                //  CustomText(
                //           text: timeago.format(
                //             DateTime.fromMicrosecondsSinceEpoch(timestamp.toInt() * 1000)
                //           ),)
                ],
              ),
             
            ]),
        ),
      ),
    );
  }
}