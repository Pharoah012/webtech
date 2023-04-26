import 'package:flutter/material.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/mainScreens/profileViewPage.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      getAllUsers().then((data) => {
    setState((){
      _users = data;
    })
   });

  }
  Future<List<dynamic>> getAllUsers()async{
    UserModel userModel = UserModel(
      userID: 'userID', 
      favFood: 'favFood', 
      favMovie: 'favMovie', 
      dateOfBirth: 'dateOfBirth', 
      yearGroup: 'yearGroup', 
      userName: 'userName', 
      email: 'email', 
      campusResidence: 'campusResidence', 
      phoneNumber: 'phoneNumber', 
      major: 'major');
      
      return userModel.getAllUsers();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final item = _users[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:ListTile(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>ProfileViewPage(
                        userModel:UserModel.fromJson(item) )));
                  },
                    title: Text(item['userName']),
                    subtitle: Text( item['email'] ),
                  )
                );
        },
        ),
    );
  }
}