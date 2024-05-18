import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/pesentation/pages/explore/widgets/explore_appbar.dart';
import 'package:online_course/src/features/course/pesentation/pages/explore/widgets/explore_category.dart';
import 'package:online_course/src/features/course/pesentation/pages/explore/widgets/explore_course_list.dart';
import 'package:online_course/src/features/course/pesentation/pages/explore/widgets/explore_search_block.dart';
import 'package:online_course/src/theme/app_color.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String selectedCategory = "";
  String searchTxt = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            // backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: ExploreAppbar(),
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
    return  SingleChildScrollView(
      child: Column(
        children: [
          ExploreSearchBlock(onSearch: (String s) { 
                  setState(() {
                    searchTxt = s;
                  });
           },),
          const SizedBox(height: 10),
          ExploreCategory(onCategorySelected: (String c) {
            setState(() {
              selectedCategory = c;
            });
            
            },),
          const SizedBox(height: 10),
          ExploreCourseList(searchText: searchTxt, selectedCategory: selectedCategory,),
        ],
      ),
    );
  }
}
