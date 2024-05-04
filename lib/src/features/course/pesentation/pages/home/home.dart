import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  String bannerUrl = '';
  
  @override
  void initState() {
    super.initState();
    fetchBanner();
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
          RoundedBannerImage(imageUrl: bannerUrl),
          
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
    Future<void> fetchBanner() async{
      try {
           FirebaseFirestore.instance.collection('app').doc('homeScreen').get().then((value) {
     setState(() {
       bannerUrl = value['banner'];
     });
    });
      }catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      _setData();
 
  }

  Future<void> _setData() async {
    User _user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection('users').doc(_user.uid).update({
      'uid': _user.uid,
      'name': _user.displayName,
      'email': _user.email,
      'pic': _user.photoURL,
      
    });
  }
}
