import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool titleshow;
  final Widget titles;
  final List<Widget> actions;

  CustomAppBar({this.title = '', this.showBackButton = true, this.titleshow = true, this.titles = const SizedBox.shrink(), this.actions = const []});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: showBackButton
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        child: InkWell(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 30,
            height: 30,
            decoration: ShapeDecoration(
              color: Color(0xFFECECEC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
      )
          : null,
      titleSpacing: -5,
      title: titleshow
          ? Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'ProximaNova',
          fontWeight: FontWeight.w600,
        ),
      )
          : titles,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
