import 'package:flutter/material.dart';

class NotificationModel {
  final String message;
  final String id;
  final String timeStamp;

  NotificationModel({
    required this.id,
    required this.message,
    required this.timeStamp
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      id: json['id'],
      message: json['message'], 
      timeStamp: json['timeStamp']
      );
  }

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'timeStamp': timeStamp,
    };
  }
   
}