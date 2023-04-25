import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webtech_project/models/PostModel.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/widgets/CustomPostTile.dart';

class ProfilePosts extends StatefulWidget {
  final UserModel user;
  const ProfilePosts({
    super.key,
    required this.user
  });

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
    List<dynamic> _posts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getUserPosts().then((data) => {
    
    setState((){
      _posts = data;
    })
   });

  }

 Future<List<dynamic>> getUserPosts()async{
   var response = await http.get(
    Uri.parse('https://webtech-384814.uc.r.appspot.com/Posts/${widget.user.email}'),
    headers:  <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
    },
    
    );
     return json.decode(response.body);
        }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: true,
     itemCount: _posts.length,
     itemBuilder: (context, index){
       final item = _posts[index];
       
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomPostTile(
                    timestamp:  12,
                    message: item['message'],
                    user: item['userName'],
                  ),
                );

     } )
    
    ;

       
      
    
  }
     }