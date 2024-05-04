import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/data/models/course_lessons.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/lesson_item.dart';
import 'package:online_course/src/theme/app_color.dart';

class CourseDetailLessonList extends StatefulWidget {
    CourseDetailLessonList({required this.lessons, super.key, this.isPurchased=false, required this.courseId, required this.sections,  this.purchaseType = const[0], required this.type});
  
  final List<CourseLessons> lessons;
  final bool isPurchased;
  final int courseId;
  final int type; //1 = video , 2 = course
  final Map<String, int> sections;
   List<int> purchaseType = [0];

  


  @override
  State<CourseDetailLessonList> createState() => _CourseDetailLessonListState();
}


class _CourseDetailLessonListState extends State<CourseDetailLessonList> {
  int selectedSection = 2;
   List<CourseLessons> lessonList = [];

  @override
  void initState() {
    fetchLessons(selectedSection);
    super.initState();
  }

 void fetchLessons(int type) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('lessons').where('courseId', isEqualTo: widget.courseId).get();
    List<CourseLessons> lessonList = [];

    for (var doc in snapshot.docs) {
      CourseLessons lesson = CourseLessons.fromJson(doc.data() as Map<String, dynamic>);
      if (lesson.type == type) {
        lessonList.add(lesson);
      }
    }

    setState(() {
      this.lessonList = lessonList;
    });
  } catch (e) {
    print(e);
  }
}




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16,),
         SizedBox(
           height: 60,
           
             child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: widget.sections.length,
               itemBuilder: (context, index) {
                 String sectionName = widget.sections.keys.toList()[index];
                 int sectionValue = widget.sections[sectionName]!;
                 
                 return GestureDetector(
                   onTap: () {
                     // Trigger method with the value of respective key
                     
                     setState(() {
                       selectedSection=sectionValue;
                       fetchLessons(sectionValue);
                     });
                     
                     print(sectionValue);
                   },
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: Chip(
                      label: Text(sectionName),
                      backgroundColor: sectionValue == selectedSection ? AppColor.primary : Colors.white,
                     ),
                   ),
                 );
               },
             ),
          
         ),
        
        Expanded(
          child: lessonList.isNotEmpty? ListView.builder(
          itemCount: widget.lessons.length,
          itemBuilder: (context, index) {
            return LessonItem(
              data: lessonList[index],           
              clickable: widget.isPurchased && widget.purchaseType.contains(selectedSection),
              type : widget.type
            );
          },
                ): const Center(child: CircularProgressIndicator(),),
        )],
    );
  }
}
