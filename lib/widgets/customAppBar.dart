import 'package:flutter/material.dart';
import 'package:webtech_project/constants.dart';
import 'customText.dart';


class CustomAppbar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final bool iscentered;
  final Color color;
  final List<Widget>? actions;
  final VoidCallback? onbacktapped;
  final bool istransparent;
  
  const CustomAppbar({
    super.key,
    this.istransparent = false,
    this.actions,
    this.color = kBlack,
    this.iscentered = false,
    this.onbacktapped,
    required this.title
    });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: widget.istransparent?Colors.transparent: widget.color,
      title: CustomText(
        text: widget.title,
        isbold: true,
        color: widget.istransparent? kWhite:widget.color,
      ),
      centerTitle: widget.iscentered,
      actions: widget.actions,
      leading: widget.onbacktapped !=null ? IconButton(
        onPressed: widget.onbacktapped,
        icon:  Icon(Icons.arrow_back, color: widget.istransparent?kWhite:kBlack,)): const SizedBox.shrink(),
      

    );
    
  }
}