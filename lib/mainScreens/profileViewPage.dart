import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/mainScreens/blankPage.dart';
import 'package:webtech_project/mainScreens/profileInfo.dart';
import 'package:webtech_project/mainScreens/profilePosts.dart';
import 'package:webtech_project/widgets/customAppBar.dart';
import 'package:webtech_project/widgets/customButton.dart';
import 'package:webtech_project/widgets/customProfileHeader.dart';
import 'package:webtech_project/widgets/customTabItem.dart';
import 'package:webtech_project/widgets/customText.dart';
import 'package:webtech_project/widgets/customTextField.dart';

// This page will display the users profile information and ways to edit it 
// it will also show their previous posts


class ProfileViewPage extends StatefulWidget {
  final UserModel userModel;
  const ProfileViewPage({
    super.key,
    required this.userModel
    });

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _movieController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final Future<SharedPreferences> _prefs =  SharedPreferences.getInstance();
  bool isUser = true;

  @override
  void initState() {
    setControllers();
    super.initState();
    checkEditAccess();
  }

   Future<void> checkEditAccess()async{
    SharedPreferences prefs =  await _prefs;
    String userEmail = prefs.getString('userEmail').toString();

    if(widget.userModel.email == userEmail){
           setState(() {
        isUser = true;
      });
      
      }
    else{
      setState(() {
        isUser = false;
      });
    }
     
    
      }
    
      
 

   
    //       GestureDetector(
    //         onTap: (){
    //           // Edit Page
    //           showDialog(
    //             context: context,
    //             builder: ((context) => SimpleDialog(
    //               title: CustomText(text:'Edit your Details' ,),
    //               children: [
    //                   // Create Date picker for date of birth
    //                   // CustomTextField(
    //                   //   labelText: ,
    //                    SimpleDialogOption(
    //                     child: CustomTextField(
    //                       controller: _phoneController,
    //                       labelText: 'Your phone Number',
    //                     ),
    //                   ),
    //                    SimpleDialogOption(
    //                     child: CustomTextField(
    //                       controller: _yearController,
    //                       labelText: 'Your year group',
    //                     ),
    //                   ),
    //                    SimpleDialogOption(
    //                     child: CustomTextField(
    //                       controller: _majorController,
    //                       labelText: 'Your major',
    //                     ),
                        
    //                   ),
    //                    SimpleDialogOption(
    //                     child: CustomTextField(
    //                       controller: _dobController,
    //                       labelText: 'Your Date of Birth',
    //                     ),
    //                   ),
    //                   const SizedBox(height: 10,),
    //                   SimpleDialogOption(
    //                     child: DropdownButton(
    //                       hint: const CustomText( 
    //                         text: 'Are you a campus resident?'),
    //                       items: const[
    //                       DropdownMenuItem(
    //                         value: 'True',
    //                         child: CustomText(
    //                         text: 'True')),
    //                       DropdownMenuItem(
    //                         value: 'False',
    //                         child: CustomText(
    //                         text: 'False',
    //                       ))
    //                     ],
    //                     isExpanded: true,
    //                     onChanged: (value){
    //                       setState(() {
    //                         dropDownValue = value.toString();
    //                       });
    //                     },
                        
                        
    //                     ),
    //                   ),
    //                   SimpleDialogOption(
    //                     child: CustomTextField(
    //                       controller: _movieController,
    //                       labelText: 'Your favourite movie',
    //                     ),
    //                   ),
    //                   SimpleDialogOption(
    //                     child: CustomTextField(
    //                       controller: _foodController,
    //                       labelText: 'Your favourite food',
    //                     ),
    //                   ),
    //                   SimpleDialogOption(
    //                     onPressed: (){
    //                         UserModel userModel = UserModel(
    //                         userID: widget.userModel.userID,
    //                         favFood: _foodController.text,
    //                         favMovie: _movieController.text,
    //                         dateOfBirth: _dobController.text,
    //                         yearGroup: _yearController.text,
    //                         userName: widget.userModel.userName,
    //                         email: widget.userModel.email,
    //                         campusResidence: dropDownValue,
    //                         phoneNumber: _phoneController.text,
    //                         major:_majorController.text);
    //                         userModel.updateUserDetails(widget.userModel.email);
    //                     },
    //                     child: CustomText(
    //                       text: 'Edit Details',
    //                       color: kPrimary,
    //                       ),
    //                   ),
    //                   SimpleDialogOption(
    //                     onPressed: (){
    //                     Navigator.of(context).pop();
    //                     },
    //                     child: CustomText(text: 'Close',),
    //                   ),
    //               ],
    //             ) ));
    //         },
    //         child: const Padding(
    //           padding:  EdgeInsets.all(10.0),
    //           child:  CustomText(
    //             text: 'Edit your Profile',
    //             color: kWhite,
    //           ),
    //         ));
        
    // }
    // else{
    //   return const SizedBox.shrink();
    // }
    
  // }
  Widget editUserButton(){
    return 
          GestureDetector(
            onTap: (){
              // Edit Page
              showDialog(
                context: context,
                builder: ((context) => SimpleDialog(
                  title: CustomText(text:'Edit your Details' ,),
                  children: [
                      // Create Date picker for date of birth
                      // CustomTextField(
                      //   labelText: ,
                       SimpleDialogOption(
                        child: CustomTextField(
                          controller: _phoneController,
                          labelText: 'Your phone Number',
                        ),
                      ),
                       SimpleDialogOption(
                        child: CustomTextField(
                          controller: _yearController,
                          labelText: 'Your year group',
                        ),
                      ),
                       SimpleDialogOption(
                        child: CustomTextField(
                          controller: _majorController,
                          labelText: 'Your major',
                        ),
                        
                      ),
                       SimpleDialogOption(
                        child: CustomTextField(
                          controller: _dobController,
                          labelText: 'Your Date of Birth',
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SimpleDialogOption(
                        child: DropdownButton(
                          hint: const CustomText( 
                            text: 'Are you a campus resident?'),
                          items: const[
                          DropdownMenuItem(
                            value: 'True',
                            child: CustomText(
                            text: 'True')),
                          DropdownMenuItem(
                            value: 'False',
                            child: CustomText(
                            text: 'False',
                          ))
                        ],
                        isExpanded: true,
                        onChanged: (value){
                          setState(() {
                            dropDownValue = value.toString();
                          });
                        },
                        
                        
                        ),
                      ),
                      SimpleDialogOption(
                        child: CustomTextField(
                          controller: _movieController,
                          labelText: 'Your favourite movie',
                        ),
                      ),
                      SimpleDialogOption(
                        child: CustomTextField(
                          controller: _foodController,
                          labelText: 'Your favourite food',
                        ),
                      ),
                      SimpleDialogOption(
                        onPressed: (){
                            UserModel userModel = UserModel(
                            userID: widget.userModel.userID,
                            favFood: _foodController.text,
                            favMovie: _movieController.text,
                            dateOfBirth: _dobController.text,
                            yearGroup: _yearController.text,
                            userName: widget.userModel.userName,
                            email: widget.userModel.email,
                            campusResidence: widget.userModel.campusResidence,
                            phoneNumber: _phoneController.text,
                            major:_majorController.text);
                            try{
                            userModel.updateUserDetails(widget.userModel.email);

                            }catch(e){
                              print(e);
                            }
                        },
                        child: CustomText(
                          text: 'Edit Details',
                          color: kPrimary,
                          ),
                      ),
                      SimpleDialogOption(
                        onPressed: (){
                        Navigator.of(context).pop();
                        },
                        child: CustomText(text: 'Close',),
                      ),
                  ],
                ) ));
            },
            child: const Padding(
              padding:  EdgeInsets.all(10.0),
              child:  CustomText(
                text: 'Edit your Profile',
                color: kWhite,
              ),
            ));
  }

  setControllers(){
    setState(() {
      _dobController.text= widget.userModel.dateOfBirth;
      _majorController.text = widget.userModel.major;
      _phoneController.text = widget.userModel.phoneNumber;
      _yearController.text = widget.userModel.yearGroup;
      _movieController.text = widget.userModel.favMovie;
      _foodController.text = widget.userModel.favFood;
      dropDownValue = widget.userModel.campusResidence;
    });
  }
String profileTab ='Posts';
String dropDownValue = '';

  Widget _profiletab(){
    return  Row(
      children: [
       SizedBox(
        width: MediaQuery.of(context).size.width*0.4,
         child: Center(
           child: CustomTabItem(
            text: 'Your Profile',
            color: profileTab == 'Profile'? kPrimary.withOpacity(0.8):kGrey,
            visibleColor: profileTab == 'Profile'? kPrimary.withOpacity(0.8):kWhite, 
            ontapped: (){
              // change page
               setState(() {
                profileTab = 'Profile';
              });
            },
           ),
         ),
       ),
 
       SizedBox(
        width: MediaQuery.of(context).size.width*0.4,
         child: CustomTabItem(
          text: 'Your Posts',
          color: profileTab == 'Posts'? kPrimary.withOpacity(0.8):kGrey,
          visibleColor: profileTab == 'Posts'? kPrimary.withOpacity(0.8):kWhite,
          ontapped: (){
            // change Page
            setState(() {
              profileTab = 'Posts';
            });
          },
       
         ),
       )
      ],
    );
  }

  Widget _switchProfilePage(){
    switch(profileTab){
      case 'Profile':
        return  
        ProfileInfo(
          user:widget.userModel ,
        );
      
      case 'Posts':
        return  ProfilePosts(user: widget.userModel,);

      default :
        return BlankPage();
    }
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        istransparent: true,
        title: 'Your Profile',
        onbacktapped: null,
        actions:[
          isUser?editUserButton():SizedBox.shrink()
        ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SizedBox(
               height: MediaQuery.of(context).size.height*0.3,
               width: MediaQuery.of(context).size.width,
                child: const CustomProfileHeader()),
             const SizedBox(height: 10,),
              _profiletab(),
             _switchProfilePage()
            ],)),
    );
  }
}