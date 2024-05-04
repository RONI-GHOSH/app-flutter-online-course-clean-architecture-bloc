import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/core/errors/exception.dart';
import 'package:online_course/core/services/fast_search_service.dart';
import 'package:online_course/core/utils/app_navigate.dart';
import 'package:online_course/core/utils/app_util.dart';
import 'package:online_course/src/features/course/data/models/course_model.dart';
import 'package:online_course/src/features/course/domain/entities/course.dart';
import 'package:online_course/src/features/course/pesentation/bloc/explore/course_bloc.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/course_detail.dart';
import 'package:online_course/src/features/course/pesentation/pages/explore/widgets/course_item.dart';
import 'package:online_course/src/widgets/custom_progress_indicator.dart';

class ExploreCourseList extends StatefulWidget {
  final String searchText;
  final String selectedCategory;

  const ExploreCourseList( {super.key,required this.searchText, required this.selectedCategory,});

  @override
  State<ExploreCourseList> createState() => _ExploreCourseListState();
}

class _ExploreCourseListState extends State<ExploreCourseList> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: 
    getCourses(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CustomProgressIndicator();
      }
      if (snapshot.hasError) {
        return Center(
          child: Text('Something went wrong: ${snapshot.error}'),
        );
      }

      if (!snapshot.hasData) {
        return const Center(
          child: Text('No courses found'),
        );
      }

      List<CourseModel> courses = snapshot.data as List<CourseModel>;
      return _buildItemList(courses);

    });
  }

  Widget _buildItemList(List<Course> courses) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return CourseItem(
          onTap: () {
            AppNavigator.to(
              context,
              CourseDetailPage(
                course: courses[index],
                isHero: true,
              ),
            );
          },
          course: courses[index],
          width: MediaQuery.of(context).size.width,
        );
      },
    );
  }
   Future<List<CourseModel>> getCourses() async {
    try {
      // dummy data
      // return coursesData.map((e) => CourseModel.fromMap(e)).toList();

      // Create an empty list to hold CourseModel instances
      List<CourseModel> courseModels = [];

      // Perform the Firestore query
      Query query =  FirebaseFirestore.instance
          .collection('courses');
         




      if(widget.searchText.isNotEmpty){
        // query = query
        //     .where('title', isGreaterThanOrEqualTo: widget.searchText)
        //     .limit(20);
           try {
        var docIds = await getDocIdsBySearchTerm(widget.searchText,'course');

        if (docIds.isNotEmpty) {
          query =
              query.where(FieldPath.documentId, whereIn: docIds);
        } else {}
      } catch (e) {
        if (kDebugMode) {
          print('search error $e');
        }
      }   


      }else if(widget.selectedCategory.isNotEmpty){
        query = query
            .where('tags', arrayContains: widget.selectedCategory)
            .limit(20);
      }else{
        query = query.limit(20);
      }
      QuerySnapshot querySnapshot = await query.get();    

      // Iterate over the documents and convert them to CourseModel instances
      for (var courseDoc in querySnapshot.docs) {
        // Extract data from the document
        Map<String, dynamic> courseData =
            courseDoc.data() as Map<String, dynamic>;

        // Create a CourseModel instance from the extracted data
        CourseModel courseModel = CourseModel.fromMap(courseData);

        // Add the CourseModel instance to the list
        courseModels.add(courseModel);
      }

      // Return the list of CourseModel instances
      return courseModels;

      // final result = await http.get(Uri.parse(NetworkUrls.getCourses));
      // if (result.statusCode == 200) {
      //   return CourseMapper.jsonToCourseModelList(result.body);
      // }
      // return [];
    } catch (e) {
      throw ServerException();
    }
  }
}
