import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_course/src/features/course/data/datasources/course_content_datasource.dart';
import 'package:online_course/src/features/course/data/models/course_lessons.dart';
import 'package:online_course/src/features/course/data/models/notes_model.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/widgets/course_detail_lesson_list.dart';
import 'package:online_course/src/theme/app_color.dart';

class CourseDetailTabBar extends StatefulWidget {
  final int courseId;
  final bool isPurchased;
  final List<int> purchaseType;
  final Map<String, int> sections;
  const CourseDetailTabBar({super.key, required this.courseId, this.isPurchased=false, required this.sections,this.purchaseType = const [0]});

  @override
  State<CourseDetailTabBar> createState() => _CourseDetailTabBarState();
}

class _CourseDetailTabBarState extends State<CourseDetailTabBar>
    with SingleTickerProviderStateMixin {
   

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    fetchSections();
  }
    void fetchSections() async{
    QuerySnapshot snapshot =await  FirebaseFirestore.instance.collection('courses').where('id' , isEqualTo: widget.courseId).get();
    // ignore: unnecessary_null_comparison
    if(snapshot!=null && snapshot.docs!=null){
        var data =  snapshot.docs[0].data() as  Map<String, dynamic> ;
    
        (data['sections'] as Map<String, dynamic>).forEach((key, value) {
            widget.sections[key] = value as int; // Assuming values are always integers
        });
        setState(() {
          
        });
        
        print(widget.sections);
    }
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
      labelColor: Color(4283521938),
      isScrollable: false,
      indicatorColor: AppColor.actionColor,
      tabs: const [
        Tab(
          child: Text(
            "Lessons",
            style: TextStyle(
              // color: AppColor.darker, 
              fontSize: 16),
          ),
        ),
        Tab(
          child: Text(
            "Exercises",
            style: TextStyle(
              // color: AppColor.darker, 
              fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBarPages() {
    return FutureBuilder(
      future: fetchCoursesLessons(widget.courseId, 'lessons'),
      builder: (BuildContext context, AsyncSnapshot<List<CourseLessons>> snapshot) { 

        if (!snapshot.hasData) {
          return const Center(child: Text('No lessons available'));
        }
        return Container(
        constraints: const BoxConstraints(minHeight: 150, maxHeight: 350),
        width: double.infinity,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            CourseDetailLessonList(lessons: snapshot.data ?? [], isPurchased: widget.isPurchased, purchaseType: widget.purchaseType, courseId: widget.courseId, sections:widget.sections, type: 1,),
           FutureBuilder(
            future: fetchCoursesLessons(widget.courseId, 'exercises'),
            builder: (BuildContext context, AsyncSnapshot<List<CourseLessons>> snapshot) { 
            
            if (!snapshot.hasData) {
              return const Center(child: Text('No exercises available'));
            }
            return Container(
            constraints: const BoxConstraints(minHeight: 150, maxHeight: 350),
            width: double.infinity,
            child: CourseDetailLessonList(lessons: snapshot.data ?? [], purchaseType: widget.purchaseType, isPurchased: widget.isPurchased, courseId: widget.courseId, sections:widget.sections,type : 2),
          );
        },
           ),

          ],
        ),
      );

       },
    
    );
  }
  Future<List<NotesModel>> fetchNotes() async {
  List<NotesModel> notesList = [];

  try {
    // Get a reference to the 'pyq' collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('pyq').get();

    // Iterate through the documents in the collection
    for (var doc in querySnapshot.docs) {
      // Extract data from each document and create a NotesModel object
      NotesModel note = NotesModel(
        title: doc['title'],
        subtitle: doc['subtitle'],
        url: doc['url'], timestamp: doc['timestamp'] as Timestamp,
      );
      notesList.add(note);
    }
  } catch (e) {
    // Handle any errors that occur during the fetch operation
    print('Error fetching notes: $e');
    // You can throw the error here if you want to handle it elsewhere
    // throw e;
  }

  return notesList;
}
}
