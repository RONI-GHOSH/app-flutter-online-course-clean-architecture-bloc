import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_course/core/utils/app_navigate.dart';
import 'package:online_course/src/features/course/data/models/course_model.dart';
import 'package:online_course/src/features/course/domain/entities/course.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/course_detail.dart';
import 'package:online_course/src/theme/app_color.dart';
import '../../../../../../widgets/custom_image.dart';

class MyCourseItem extends StatefulWidget {
  const MyCourseItem(
      {required this.data,
      Key? key,
      this.progressColor = AppColor.blue,
      this.completedPercent = 0.0})
      : super(key: key);
  final CourseModel data;
  final Color progressColor;
  final double completedPercent;

  @override
  State<MyCourseItem> createState() => _MyCourseItemState();
}

class _MyCourseItemState extends State<MyCourseItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
         
         Map<int, List<int>> courses = await fetchMapFromFirestore();
         print(courses);

         

         AppNavigator.to(
              context,
              CourseDetailPage(course: widget.data,isPurchased: true,purchasedType:courses[widget.data.id] ?? [0]),
            );
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: _buildCourseInfo()),
    );
  }

  Widget _buildCourseInfo() {
    return Row(
      children: [
        CustomImage(
          widget.data.image,
          radius: 10,
          height: 70,
          width: 70,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: AppColor.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
             // _buildProgressLessonBlock(),
              const SizedBox(
                height: 7,
              ),
              LinearProgressIndicator(
                value: 
                // data["complete_percent"].toDouble() ??
                 1.0,
                backgroundColor: widget.progressColor.withOpacity(.2),
                valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
              )
            ],
          ),
        ),
      ],
    );
  }

Future<Map<int, List<int>>> fetchMapFromFirestore() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc('me').get();
    
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    
    if (data != null && data.containsKey('mycourses')) {
      // Get the map field from the document
      Map<String, dynamic> myCoursesMap = data['mycourses'] as Map<String, dynamic>;
      
      // Convert the map field to the desired structure
      Map<int, List<int>> resultMap = {};
      myCoursesMap.forEach((key, value) {
        int intKey = int.parse(key);
        List<int> intListValue = List<int>.from(value as List<dynamic>);
        resultMap[intKey] = intListValue;
      });

      return resultMap;
    } else {
      print('Field "mycourses" not found or not in the expected format');
      return {}; // Return an empty map if the field is not found or not in the expected format
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {}; // Return an empty map in case of an error
  }
}


}
