import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/homeScreen.dart';
import 'package:webtech_project/widgets/customText.dart';
import 'package:webtech_project/widgets/customTextField.dart';
import 'package:webtech_project/widgets/customButton.dart';


class LogInProfile extends StatefulWidget {
  const LogInProfile({super.key});

  @override
  State<LogInProfile> createState() => _LogInProfileState();
}

class _LogInProfileState extends State<LogInProfile> {
  final GlobalKey<ScaffoldState>_key = GlobalKey<ScaffoldState>();
  String dropDownValue= '';
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();

 // Display image beside form to make more presentable
  Widget sideImage(){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width *0.55,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/sidepicture.png'),
          fit: BoxFit.cover
          )),

    );

}



  Widget profileForm(){
    return  SizedBox(
      width: MediaQuery.of(context).size.width *0.45,
      child:
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const CustomText(
                text: 'Connect With Us',
                fontSize: 30,
                isbold: true,
                color: kPrimary,
                ),
             const SizedBox(height: 15,),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                    ),
                      const SizedBox(height: 10,),
                    CustomTextField(
                      controller: studentIdController,
                      labelText: 'Student ID',
                    ),
                  ],
                ),
              ),
         
              const SizedBox(height: 10,),
              CustomButton(
                width: MediaQuery.of(context).size.width*0.9,
                text: 'Log In',
                color: kGrey,
                onPressed: ()async{
                  if(_formkey.currentState!.validate()){
                    UserModel userModel = UserModel(
                    userID: studentIdController.text, favFood: 'favFood', favMovie: 'favMovie', dateOfBirth: 'dateOfBirth', yearGroup: 'yearGroup', userName: 'userName', email: emailController.text, campusResidence: 'campusResidence', phoneNumber: 'phoneNumber', major: 'major');
                    UserModel userdoc = await userModel.getUser(emailController.text);
                   
                   //authentication logic
                   //User email and id typed are compared with details gotten from firestore
                    if(
                      userdoc.email == emailController.text
                      && userdoc.userID == studentIdController.text){
                        // Obtain shared preferences.
                        try{
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        // Save user login session
                        await prefs.setString('userEmail', emailController.text);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (context)=> 
                          HomeScreen(user: userdoc,)), (route) => false);
                        }
                        catch(e){
                         ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content: 
                              CustomText(text: 'Sth went wrong',
                              color: kWhite,
                              )));
                        }
                       
                    }

                    else{
                   
                      ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                          content: CustomText(
                            text: 'Something went Wrong',
                            color: kWhite,
                          )));
                    }
                  }
                  
                
                },
              )
            ],
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Row(
        children: [
          profileForm(),
          sideImage()
        ],)
      ),
    );
  }
}