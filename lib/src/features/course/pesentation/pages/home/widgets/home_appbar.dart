import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/pesentation/pages/home/widgets/rounded_image.dart';
import 'package:online_course/src/widgets/notification_box.dart';
import 'package:online_course/src/theme/app_color.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({ super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     
        RoundedImage(imageUrl:user?.photoURL ?? 'https://th.bing.com/th/id/OIP.IrUBHhdMo6wWLFueKNreRwHaHa?rs=1&pid=ImgDetMain',)
       
       ,
       const SizedBox(
          width: 10,
        ),


        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.displayName ?? 'Dear student',
                style: const TextStyle(
                  color: AppColor.labelColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Welcome back!",
                style: TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const NotificationBox(
          notifiedNumber: 1,
        )
      ],
    );
  }
}
