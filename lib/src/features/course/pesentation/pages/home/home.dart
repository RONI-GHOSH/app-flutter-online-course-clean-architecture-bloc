import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_course/core/utils/dummy_data.dart';
import 'package:online_course/src/features/course/pesentation/pages/home/widgets/home_appbar.dart';
import 'package:online_course/src/features/course/pesentation/pages/home/widgets/home_banner.dart';
import 'package:online_course/src/features/course/pesentation/pages/home/widgets/home_category.dart';
import 'package:online_course/src/features/course/pesentation/pages/home/widgets/home_feature_block.dart';
import 'package:online_course/src/features/course/pesentation/pages/home/widgets/home_recommend_block.dart';
import 'package:online_course/src/theme/app_color.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _user = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: HomeAppBar(user: _user,),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBody(),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedBannerImage(imageUrl: 'https://th.bing.com/th/id/OIP.iV9mxH3h0AXCl8_vSlARjwAAAA?rs=1&pid=ImgDetMain'),
          
          HomeCategory(
            categories: categories,
          ),
          const SizedBox(
            height: 15,
          ),
          const HomeFeatureBlock(),
          const SizedBox(
            height: 15,
          ),
          const HomeRecommendBlcok(),
        ],
      ),
    );
  }
}
