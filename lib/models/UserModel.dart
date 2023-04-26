import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/profile/loginprofile.dart';
import 'package:webtech_project/widgets/customText.dart'; 

var apiUrl = 'https://webtech-384814.uc.r.appspot.com/Users';

class UserModel{
  final String userID;
  final String favFood;
  final String favMovie;
  final String dateOfBirth;
  final String yearGroup;
  final String userName;
  final String email;
  final String campusResidence;
  final String phoneNumber;
  final String major;


 UserModel({
  required this.userID,
  required this.favFood,
  required this.favMovie,
  required this.dateOfBirth,
  required this.yearGroup,
  required this.userName,
  required this.email,
  required this.campusResidence,
  required this.phoneNumber,
  required this.major
});

factory UserModel.fromJson(Map<String, dynamic>json) {
  return  UserModel(
    userID: json['userID'], 
    favFood: json['favFood'], 
    favMovie: json['favMovie'], 
    dateOfBirth: json['dateOfBirth'], 
    yearGroup: json['yearGroup'], 
    userName: json['userName'], 
    email: json['email'], 
    campusResidence: json['campusResidence'], 
    phoneNumber: json['phoneNumber'], 
    major: json['major']
    );
}

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userID': userID,
      'favFood': favFood,
      'favMovie': favMovie,
      'yearGroup': yearGroup,
      'dateOfBirth': dateOfBirth,
      'campusResidence': campusResidence,
      'phoneNumber': phoneNumber,
      'major': major,
      'userName': userName
    };

  }

  // create user account
Future <void> createtUserAccount(context) async {
 var response = await http.post(
  Uri.parse(apiUrl),
  headers: 
    <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
  },
  body: jsonEncode(toMap())
  );
  if(response.statusCode != 201){
 
     Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: CustomText(
      text: 'Something went wrong',
      color: kWhite,
    )));
  
  }
  else{
       Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context)=> const LogInProfile()));

  }
 

}

  Future<void> updateUserDetails(email) async {
    await http.patch(
      Uri.parse('$apiUrl/$email'), 
      headers:  <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
    },
      body: jsonEncode(toMap())
      );

  }

// Get Specific user
  Future<UserModel> getUser(userEmail) async {
   var response = await http.get(
    Uri.parse('$apiUrl/$userEmail'),
    headers:  <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
    },
    
    );


   if(response.statusCode == 201){
    final data = json.decode(response.body);
    final user = UserModel.fromJson(data);
    return user;
   }
   else{
    throw Exception('Sth went Wrong');
   }

  }

  // Get all users
   Future<List<dynamic>> getAllUsers() async {
   var response = await http.get(
    Uri.parse(apiUrl),
    headers:  <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
    },
    
    );
    return json.decode(response.body);

  }
}

