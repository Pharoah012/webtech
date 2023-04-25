
// import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:webtech_project/models/PostModel.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/widgets/CustomPostTile.dart';
import 'package:webtech_project/widgets/customButton.dart';
import 'package:webtech_project/widgets/customText.dart';
import 'package:webtech_project/widgets/customTextField.dart';

// Displays posts of users

class FeedPage extends StatefulWidget {

  const FeedPage({Key? key,
  }) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = getPosts();
  }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController= TextEditingController();
  final String pid = const Uuid().v4();
   late Stream<List<PostModel>> _stream;

  Stream<List<PostModel>> getPosts() async* {
    while (true) {
       var response = await http.get(
    Uri.parse('https://webtech-384814.uc.r.appspot.com/Posts'),
    headers:  <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    
    },
    
    );
   
      final List<dynamic> data = jsonDecode(response.body);
      final List<PostModel> posts = data.map((post) => PostModel.fromJson(post)).toList();
      yield posts;
      await Future.delayed(Duration(seconds: 5));
    }
  }

  
    postList() {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context,  dynamic snapshot){
        if (snapshot.hasData) {
            List<Padding> postList = [];
        final posts = snapshot.data;
      for (var element in posts!) {
        print('object1s');

       postList.add(Padding(
         padding: const EdgeInsets.all(8.0),
         child: CustomPostTile(
          timestamp: element.timestamp,
          message: element.message, user: element.userEmail),
       ));
      }
       return Column(children: postList ,);
          
      }
      else{
        print('object');
        return SizedBox.shrink();
      }

    
            // return ListView.builder(
            //  // itemCount: posts!.length,
            //   itemBuilder: (context, index) {
            //     return Text('data');
            //   });
      
    });
  }


  Widget _customSideBar(){
    return
    Container(
      decoration: BoxDecoration(
        color: kGrey.withOpacity(0.2),
        border: Border.lerp(Border.all(), Border.all(width: 0,color: kGrey), 1)
      ),
      width: MediaQuery.of(context).size.width*0.2,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
        CustomText(text: 'Notifications'),

          // _customDrawerItem('Profile'),
          // _customDrawerItem('FeedPage'),
          // _customDrawerItem('About Us'),
          // const Spacer(),
          
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.55,
                height: MediaQuery.of(context).size.height,
                child: ListView(

                  children: [
                    Row(
                      children: [
                        const CustomText(
                          text: 'Your Feed',
                          color: kGrey,
                          isbold: true,
                          fontSize: 23,
                        ),
                        const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context, 
                            builder: (context){
                              return SimpleDialog(
                                title: CustomText(
                                  text: 'Create Post',
                                  ),
                                children: [
                                  SimpleDialogOption(
                                    child: CustomTextField(
                                      controller: _emailController,
                                      labelText: 'Email',
                                    ),
                                  ),
                               
                                  SimpleDialogOption(
                                    child: CustomTextField(
                                      controller: _messageController ,
                                      labelText: 'Whats on your mind?',
                                    ),
                                  ),
                                  SimpleDialogOption(
                                    child: CustomButton(
                                      text: 'Create Post',
                                      onPressed:(){
                                        // remove dialog
                                        // Navigator.of(context).pop();      
                                        //call post api and create post in firestore
                                        PostModel post = PostModel(
                                          timestamp: 1.0,
                                          userName: '',
                                        //  timestamp: DateTime.now(),
                                          message: _messageController.text,
                                          postID: pid, userEmail: _emailController.text, 
                                       );
                                          post.createtUserPost(context);
                                        //show successful message
                                      } ),
                                  )
                                ],
                              );
                            });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add,
                              color: kGrey,
                              ),
                            CustomText(
                              text: 'Create Post',
                              color: kGrey,
                              ),
                          ],
                        ),
                      )
                      ],
                    ),
                CustomText(text: 'Share your best of ideas and memories with your friends here'),
                
                postList()
            
                
                ]),
              ),
            ),
            const Spacer(),
            _customSideBar()
          ],
        ),
      ),
    );
  }
}