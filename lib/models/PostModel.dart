import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webtech_project/widgets/customText.dart';


var apiUrl = 'https://webtech-384814.uc.r.appspot.com/Posts';

class PostModel{
  final String postID;
  final String userEmail;
  final String userName;
  final String message;
  final double timestamp;



 PostModel({
  required this.postID,
  required this.userName,
  required this.timestamp,
  required this.userEmail,
  required this.message,

});

factory PostModel.fromJson(Map<String, dynamic> json){
  return PostModel(
    userName: json['userName'],
    postID: json['PostID'], 
    timestamp: json['timeStamp'], 
    userEmail: json['userEmail'], 
    message: json['message']  , 
    );
}

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'userName': userEmail,
      'message': message,
      'PostID': postID,
    };
  }

// create post 
Future <void> createtUserPost(context) async {
 var response = await http.post(
  Uri.parse(apiUrl),
  headers: 
    <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
  },
  body: jsonEncode(toMap())
  );
  if(response.statusCode != 201){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: CustomText(text: 'Post was unsuccessful',)));

  
  }
  else{
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: CustomText(text: 'Posted Successfully',)));


  }
 

}


//   Future<List<PostModel>> getUserPosts() async {
//    var response = await http.get(
//     Uri.parse(apiUrl),
//     headers:  <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
    
//     },
    
//     );
//      List<dynamic> data =jsonDecode(response.body);
   
//      List<PostModel> posts = [];
//      for (var postJson in data) {
//        PostModel post = PostModel.fromJson(postJson);
//        posts.add(post);
//      }
//     //   yield posts;
    
   
  

//   }

// }

}

