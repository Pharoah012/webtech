
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/homeScreen.dart';
import 'package:webtech_project/profile/createprofile.dart';


class SplashScreen extends StatefulWidget {
  
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   String page = '';
  final Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();

  @override
  void initState() {
   //check user login
   checkUserLogin();
  
    super.initState();
  }

  Future<UserModel> getUser(String email)async{
      UserModel user = UserModel(
      userID: '', favFood: 'favFood', favMovie: 'favMovie', dateOfBirth: 'dateOfBirth', yearGroup: 'yearGroup', userName: 'userName', email: '', campusResidence: 'campusResidence', phoneNumber: 'phoneNumber', major: 'major');
      UserModel userModel = await user.getUser(email);
  
     return userModel;        
  }

  void checkUserLogin()async{
  // Obtain shared preferences.
    try{
      final SharedPreferences prefs = await _prefs;
      final String? email = prefs.getString('userEmail');
        if(email!.isEmpty){
        
        Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(
          builder: (context)=> const CreateProfileAccount() ), (route) => false);
          
        }
      else{
        
        UserModel user = await getUser(email);
        Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(
          builder: (context)=> HomeScreen(user: user,) ), (route) => false);
          
        



        }
        
  }catch(e){
      Navigator.pushAndRemoveUntil(context,
     MaterialPageRoute(
      builder: (context)=> CreateProfileAccount() ), (route) => false);
      
  }
  }



  
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/ashesi_logo.png')
          ],),
      ),
    );
  }
}