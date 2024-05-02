import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_course/core/services/auth_service.dart';
import 'package:online_course/src/widgets/custom_image.dart';

// ignore: must_be_immutable
class AccountProfileBlock extends StatelessWidget {
   AccountProfileBlock({required this.profile, super.key});
  final Map profile;
   User? user =AuthService().user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(
          user?.photoURL ?? 'https://th.bing.com/th/id/OIP.IrUBHhdMo6wWLFueKNreRwHaHa?rs=1&pid=ImgDetMain',
          width: 70,
          height: 70,
          radius: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user?.displayName??'Student',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
