import 'package:flutter/material.dart';
import 'package:online_course/core/utils/app_navigate.dart';
import 'package:online_course/src/features/account/presentation/pages/account/widgets/setting_item.dart';
import 'package:online_course/src/features/course/pesentation/pages/favorite/favorite.dart';
import 'package:online_course/src/theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountBlock1 extends StatelessWidget {
  const AccountBlock1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.darker,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SettingItem(
            title: "Official channel",
            leadingIcon:  "assets/icons/logo_yt.svg",
            bgIconColor: AppColor.blue,
             onTap: () {
               launchUrl(Uri.parse('https://www.youtube.com/@examplanb'));
            }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Follow us",
            leadingIcon: "assets/icons/logo_fb.svg",
            bgIconColor: AppColor.green,
            onTap: ()  {
             launchUrl(Uri.parse('https://facebook.com/profile.php?id=61558275388856&mibextid=ZbWKwL'));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
              
            ),
          ),
          SettingItem(
            title: "Instagram page",
            leadingIcon: "assets/icons/logo_ig.svg",
            bgIconColor: AppColor.primary,
            onTap: () {
               launchUrl(Uri.parse('https://instagram.com/examplanbofficial?igsh=MW9oZmQ0cW1zMWw3MQ=='));
            },
          ),
            SettingItem(
            title: "Telegram",
            leadingIcon: "assets/icons/logo_telegram.svg",
            bgIconColor: AppColor.primary,
             onTap: () {
              launchUrl(Uri.parse('https://telegram.me/examplanbofficials'));
            },
          ),
             SettingItem(
            title: "Channel",
            leadingIcon: "assets/icons/logo_whatsapp.svg",
            bgIconColor: AppColor.primary,
            onTap: () {
              launchUrl(Uri.parse('https://whatsapp.com/channel/0029VaVxVLnKWEKqERsKKw1l'));
            },
          ),
        ],
      ),
    );
  }
}
