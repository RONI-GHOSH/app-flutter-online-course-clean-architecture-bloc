import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/domain/entities/course.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/course_detail_bottom_block.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/course_detail_image.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/course_detail_info.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/course_detail_tabbar.dart';
import 'package:online_course/src/theme/app_color.dart';
import 'package:online_course/src/widgets/custom_appbar.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({required this.course, this.isHero = false, Key? key, this.isPurchased=false, this.purchasedType = const [0]})
      : super(key: key);
  final Course course;
  final bool isHero;
  final bool isPurchased;
  final List<int> purchasedType ;

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  
Map<String, int> sections = {};



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.appBgColor,
      appBar: const CustomAppBar(title: "Details"),
      body: _buildBody(widget.course),
      bottomNavigationBar: !widget.isPurchased ? CourseDetailBottomBlock(course: widget.course, subjects: sections,):null,
    );
  }


      void fetchSections() async{
    QuerySnapshot snapshot =await  FirebaseFirestore.instance.collection('courses').where('id' , isEqualTo: widget.course.id).get();
    // ignore: unnecessary_null_comparison
    if(snapshot!=null && snapshot.docs!=null){
        var data =  snapshot.docs[0].data() as  Map<String, dynamic> ;
    
        (data['sections'] as Map<String, dynamic>).forEach((key, value) {
           sections[key] = value as int; // Assuming values are always integers
        });
        setState(() {});
        
        print(sections);
    }
}

  Widget _buildBody(Course course) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !widget.isPurchased? CourseDetailImage(
            course: course,
            isHero: widget.isHero,
          ):const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          CourseDetailInfo(
            course: course,
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        
           CourseDetailTabBar(courseId: course.id,isPurchased: widget.isPurchased, sections: sections,purchaseType: widget.purchasedType),
        ],
      ),
    );
  }
}
