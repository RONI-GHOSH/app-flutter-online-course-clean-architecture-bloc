import 'package:flutter/material.dart';
import 'package:online_course/src/theme/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, this.actions, super.key});
  final String title;
  final List<Widget>? actions;

  @override
  build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColor.labelColor),
      backgroundColor: AppColor.darker,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
