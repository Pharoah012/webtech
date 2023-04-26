import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/mainScreens/blankPage.dart';
import 'package:webtech_project/mainScreens/feedPage.dart';
import 'package:webtech_project/mainScreens/profileViewPage.dart';
import 'package:webtech_project/mainScreens/searchScreen.dart';
import 'package:webtech_project/profile/createprofile.dart';
import 'package:webtech_project/widgets/customText.dart';
import 'constants.dart';


class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({
    super.key,
    required this.user
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel userModel = UserModel(
    userID: 'N/A', 
    favFood: 'N/A', 
    favMovie:  'N/A', 
    dateOfBirth:  'N/A', 
    yearGroup:  'N/A', 
    userName:  'N/A', 
    email:  'N/A', 
    campusResidence: 
     'N/A', 
    phoneNumber:  'N/A', 
    major:  'N/A');


  final Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();
  
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser()async{
   UserModel userModel = await widget.user.getUser(widget.user.email);
   setState(() {
     this.userModel = userModel;
   });

    
  }

  String currentPage = 'FeedPage';

  // Create a custom Drawer for this page
  Widget _customDrawer(){
    return
    Container(
      decoration: BoxDecoration(
        border: Border.lerp(Border.all(), Border.all(width: 0,color: kGrey), 1)
      ),
      width: MediaQuery.of(context).size.width*0.2,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          DrawerHeader(
          padding: EdgeInsets.zero,
            child: Container(
             color: kPrimary.withOpacity(0.85),
             child: const Center(
              child: CustomText(
                text: 'Connect',
                fontSize: 20,
                color: kWhite,
                isbold: true,
                )),
            )),
            

          _customDrawerItem('Profile'),
          _customDrawerItem('FeedPage'),
          _customDrawerItem('Search Users'),
          _customDrawerItem('About Us'),
          const Spacer(),

        //Logout button
        ListTile(
      onTap: ()async{
        // remove variable from shared preferences 
        SharedPreferences prefs = await _prefs;
        prefs.remove('userEmail').then((value) =>  Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(
            builder: (context)=> const CreateProfileAccount()), (route) => false));
       
      },
      title: const CustomText(
        text: 'Log Out',
        color: kGrey,
        ),
      trailing: const Icon(Icons.arrow_forward_ios),
    )


          
      ]),
    );
  }

  // Create drawer items for the page
  Widget _customDrawerItem(String tileText){
    return ListTile(
      onTap: (){
        setState(() {
          currentPage = tileText;
        });
      },
      title: CustomText(
        text: tileText,
        color: kGrey,
        ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

// change the page of screen when customdrawer item is tapped
  Widget _changePage(){
   switch (currentPage){
    case 'feedPage':
      return SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height,
        child: const Scaffold());
    
    case 'Profile': 
      return SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height,
        child: ProfileViewPage(
          userModel: widget.user,

        ));

    case 'FeedPage':
      return SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height,
        child: FeedPage(user: widget.user,)); 

    case 'Search Users':
      return  SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height,
        child: const SearchScreen()); 
    default:
      return  SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height,
        child:const BlankPage());
   }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Row(children: [
     _customDrawer(),
     _changePage()
    ],)

    );
  }
}
