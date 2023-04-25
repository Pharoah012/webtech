import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'package:webtech_project/widgets/customText.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  
  Widget _customDrawerItem(String tileText, Widget page){
    return ListTile(
      onTap: ()=> Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context)=> page),
          ),
      title: CustomText(
        text: tileText,
        color: kGrey,
        ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Container()),
       //   _customDrawerItem('Profile', page)

          
      ]),
    );
  }
}