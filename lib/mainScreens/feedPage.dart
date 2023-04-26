
// import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:webtech_project/models/PostModel.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/models/notificationModel.dart';
import 'package:webtech_project/widgets/CustomPostTile.dart';
import 'package:webtech_project/widgets/customButton.dart';
import 'package:webtech_project/widgets/customText.dart';
import 'package:webtech_project/widgets/customTextField.dart';

// Displays posts of users

class FeedPage extends StatefulWidget {
final UserModel user;

  const FeedPage({Key? key,
  required this.user

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
    _notificationStream = getNotifications();
  }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController= TextEditingController();
  final String pid = const Uuid().v4();
  final String notificationID= const Uuid().v4();
   late Stream<List<PostModel>> _stream;
   late Stream<List<NotificationModel>> _notificationStream;

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
      await Future.delayed(const Duration(seconds: 5));
    }
  }
  

 Widget notificationList(){
     return StreamBuilder(
      stream: _notificationStream,
      builder: (BuildContext context,  dynamic snapshot){
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
          }
        else{
          List<Padding> postList = [];
                  final posts = snapshot.data;
                for (var element in posts!) {
                  postList.add(Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:ListTile(
                      subtitle: Text(element.message),
                      title: Text( element.userName,)
                    )
                  ));
                  }
                return Column(children: postList ,);

        }
       
      // else{
      //   return SizedBox.shrink();
      // }

    
            // return ListView.builder(
            //  // itemCount: posts!.length,
            //   itemBuilder: (context, index) {
            //     return Text('data');
            //   });
      
    });
  }
  
  Widget postList() {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context,  dynamic snapshot){
        if (snapshot.hasData) {
            List<Padding> postList = [];
        final posts = snapshot.data;
      for (var element in posts!) {
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
        return const SizedBox.shrink();
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
      child: SingleChildScrollView(
        child: Column(
        children: [
        CustomText(text: 'Notifications'),
        notificationList()

          
          
      ]),)
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

                                       NotificationModel notification = NotificationModel(
                                    
                                        notificationID: notificationID, 
                                        message: '${widget.user.userName} has created a post', 
                                        userName: widget.user.userName);
                                          post.createtUserPost(context);
                                          notification.createtNotificaton();

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