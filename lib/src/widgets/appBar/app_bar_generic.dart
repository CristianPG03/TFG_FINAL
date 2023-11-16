import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';

class AppBarGeneric extends StatelessWidget implements PreferredSizeWidget{
  final String appBarTitle;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarGeneric({
    super.key,
    required this.appBarTitle,
    this.leading,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      leading: leading,
      iconTheme: IconThemeData(
        size: 30,
        weight: 300,
        color: mainGreenColor,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}