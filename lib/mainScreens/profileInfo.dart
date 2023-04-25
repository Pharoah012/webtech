import 'package:flutter/material.dart';
import 'package:webtech_project/models/UserModel.dart';
import 'package:webtech_project/widgets/profileInfoTile.dart';


class ProfileInfo extends StatefulWidget {
  final UserModel user;
  const ProfileInfo({
    super.key,
    required this.user
    });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top:20.0,
        left: 20,
        right: 20,
        bottom: 10
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomProfileInfoTile(
            title: 'Name',
            subtitle: widget.user.userName, 
            ),
               CustomProfileInfoTile(
            title: 'Email',
            subtitle:widget.user.email, 
            ),
              CustomProfileInfoTile(
            title: 'Student Id',
            subtitle: widget.user.userID, 
            ),   
               CustomProfileInfoTile(
            title: 'Phone Number',
            subtitle: widget.user.phoneNumber, 
            ), 
            CustomProfileInfoTile(
            title: 'Date of Birth',
            subtitle: widget.user.dateOfBirth, 
            ),
               
            CustomProfileInfoTile(
            title: 'Year Group',
            subtitle: widget.user.yearGroup, 
            ),   
            CustomProfileInfoTile(
            title: 'Your Major',
            subtitle: widget.user.major, 
            ),   
            CustomProfileInfoTile(
            title: 'Campus Residence?',
            subtitle: widget.user.campusResidence, 
            ),   
            CustomProfileInfoTile(
            title: 'Your Favorite Food',
            subtitle: widget.user.favFood, 
            ),   CustomProfileInfoTile(
            title: 'Your Favorite Movie',
            subtitle: widget.user.favMovie, 
            )
        ],
      ),
    );
  }
}