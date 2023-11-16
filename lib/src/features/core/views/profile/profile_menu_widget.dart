import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: mainGrayColor.withOpacity(0.2)
        ),
        child: Icon(icon),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16).apply(color: textColor),),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: mainGrayColor.withOpacity(0.2)
        ),
        child: const Icon(
          Icons.arrow_right,
          color: Colors.grey,
          size: 18,
        ),
      ) : null,
    );
  }
}