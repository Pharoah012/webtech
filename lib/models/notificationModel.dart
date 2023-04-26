import 'dart:convert';
import 'package:http/http.dart' as http;

var apiUrl = 'https://webtech-384814.uc.r.appspot.com/Notification';


class NotificationModel {
  final String message;
  final String notificationID;

  final String userName;

  NotificationModel({
    required this.notificationID,
    required this.message,
    required this.userName
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      notificationID: json['notificationID'],
      userName: json['userName'],
      message: json['message'], 
      
      );
  }

    Map<String, dynamic> toMap() {
    return {
      'notificationID': notificationID,
      'message': message,
      'userName': userName,
    };
  }

  
// create post 
Future <void> createtNotificaton() async {
 var response = await http.post(
  Uri.parse(apiUrl),
  headers: 
    <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
  },
  body: jsonEncode(toMap())
  );
  if(response.statusCode != 201){
   
  
  }
 

  }
 

}
   



  Stream<List<NotificationModel>> getNotifications() async* {
    while (true) {
       var response = await http.get(
    Uri.parse('https://webtech-384814.uc.r.appspot.com/Notification'),
    headers:  <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
    },
    
    );
   
      final List<dynamic> data = jsonDecode(response.body);
      final List<NotificationModel> notifications = data.map((post) => NotificationModel.fromJson(post)).toList();
      yield notifications;
      await Future.delayed(const Duration(seconds: 5));
    }
  }
