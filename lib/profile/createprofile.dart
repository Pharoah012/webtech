import 'package:flutter/material.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/homeScreen.dart';
import 'package:webtech_project/profile/loginprofile.dart';
import 'package:webtech_project/splashScreen.dart';
import 'package:webtech_project/widgets/customLoader.dart';
import 'package:webtech_project/widgets/customText.dart';
import 'package:webtech_project/widgets/customTextField.dart';
import 'package:webtech_project/widgets/customButton.dart';


class CreateProfileAccount extends StatefulWidget {
  const CreateProfileAccount({super.key});

  @override
  State<CreateProfileAccount> createState() => _CreateProfileAccountState();
}

class _CreateProfileAccountState extends State<CreateProfileAccount> {
  String dropDownValue= '';
  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController favMovieController = TextEditingController();
  TextEditingController doBController = TextEditingController();
  TextEditingController yearController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController favFoodController = TextEditingController();
  TextEditingController majorController= TextEditingController();
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();



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
            children:  [
            const Padding(
              padding:  EdgeInsets.only(left:10.0),
              child:  CustomText(
                  text: 'Connect With Us',
                  fontSize: 30,
                  isbold: true,
                  color: kPrimary,
                  ),
            ),
                GestureDetector(
                  onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context)=> LogInProfile()), (route) => false);
                      }, 
                      child:
                     const CustomText(
                        text: 'Click to LogIn ',
                        color: kPrimary,
                        ),),
            Form(
              key: _formkey,
              child: Column(
                children: [
                   const SizedBox(height: 15,),
              CustomTextField(
                controller: nameController,
                labelText: 'Name',
        
              ),
             const SizedBox(height: 10,),
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
              ),
             const SizedBox(height: 10,),
              CustomTextField(
                controller: studentIdController,
                labelText: 'Student ID',
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                controller: yearController,
                labelText: 'Year group',
              ),
               const SizedBox(height: 10,),
              CustomTextField(
                controller: majorController,
                labelText: 'major',
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                controller: doBController,
                labelText: 'Date of Birth',
              ),
              
              const SizedBox(height: 10,),
              CustomTextField(
                controller: phoneController,
                labelText: 'phone Number',
              ),


              const SizedBox(height: 10,),
              DropdownButton(
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
              const SizedBox(height: 10,),
              CustomTextField(
                controller: favMovieController,
                labelText: 'Your favourite movie',
              ),
              const SizedBox(height: 10,),
              CustomTextField(
                controller: favFoodController,
                labelText: 'Your favourite food',
              ),
              const SizedBox(height: 10,),

                ]),

      
            ),
            
              CustomButton(
                width: MediaQuery.of(context).size.width*0.9,
                text: 'Create Account',
                color: kGrey,
                onPressed: (){
           
              //create new user logic
              // take user details and put it in database
              //Navigate to next page if successful
                if(_formkey.currentState!.validate()){
                   UserModel userModel = UserModel(
                      userID: studentIdController.text, 
                      favFood: favFoodController.text, 
                      favMovie: favMovieController.text, 
                      dateOfBirth: doBController.text, 
                      yearGroup: yearController.text, 
                      userName: nameController.text, 
                      email: emailController.text, 
                      campusResidence: dropDownValue, 
                      phoneNumber: phoneController.text, 
                      major: majorController.text
                      );
                    showDialog(context: context, builder: ((context) => const CustomLoader()));
                     userModel.createtUserAccount(context);
                     print('email:${emailController.text}');
              
                     


                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  const  SnackBar(
                      content: CustomText( 
                      text :'Something went wrong',
                      color: kWhite,)
                    )
                  );
                }
               

            
             // Navigator.pushNamedAndRemoveUntil(context, '/homeScreen.dart', (route) => false);
                })
            ],
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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