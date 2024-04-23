import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/data/datasources/course_content_datasource.dart';
import 'package:online_course/src/features/course/data/models/course_lessons.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/course_detail_lesson_list.dart';
import 'package:online_course/src/theme/app_color.dart';

class CourseDetailTabBar extends StatefulWidget {
  final int courseId;
  const CourseDetailTabBar({super.key, required this.courseId});

  @override
  State<CourseDetailTabBar> createState() => _CourseDetailTabBarState();
}

class _CourseDetailTabBarState extends State<CourseDetailTabBar>
    with SingleTickerProviderStateMixin {
   

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildTabBar(), _buildTabBarPages()],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: tabController,
      labelColor: Colors.redAccent,
      isScrollable: false,
      indicatorColor: AppColor.primary,
      tabs: const [
        Tab(
          child: Text(
            "Lessons",
            style: TextStyle(color: AppColor.darker, fontSize: 16),
          ),
        ),
        Tab(
          child: Text(
            "Exercises",
            style: TextStyle(color: AppColor.darker, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBarPages() {
    return FutureBuilder(
      future: fetchCoursesLessons(widget.courseId),
      builder: (BuildContext context, AsyncSnapshot<List<CourseLessons>> snapshot) { 

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
        constraints: const BoxConstraints(minHeight: 150, maxHeight: 350),
        width: double.infinity,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            CourseDetailLessonList(lessons: snapshot.data ?? []),
            const Center(
              child: Text(
                "Coming Soon!",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      );

       },
    
    );
  }
}
