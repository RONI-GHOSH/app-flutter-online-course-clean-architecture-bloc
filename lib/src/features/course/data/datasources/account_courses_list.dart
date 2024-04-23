import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:online_course/src/features/course/data/models/course_model.dart';

Future<List<CourseModel>> fetchMyCourses() async {
  try {
    // Get the Firestore document with the ID "me"
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc('me').get();

    // Check if the document exists
    if (snapshot.exists) {
      // Access the "nestedArray" field which contains arrays
      List<dynamic> nestedArray = snapshot.get('courses');

      // Now you have the specific field from the first array, you can use it as needed
      List<CourseModel> myCourses = [];

      CollectionReference reference =  FirebaseFirestore.instance
          .collection('courses');
      // ignore: avoid_function_literals_in_foreach_calls
      nestedArray.forEach((element) async {
        DocumentSnapshot courseSnapshot = await reference.where('id' ,isEqualTo: element).get().then((value) => value.docs[0]);
        Map<String, dynamic> courseData = courseSnapshot.data() as Map<String, dynamic>;
        CourseModel courseModel = CourseModel.fromMap(courseData);
        myCourses.add(courseModel);
      });
      return myCourses;



    } else {
       return [];
    }
  } catch (e) {
    
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
    return [];
  }
}


Future<int> addCourseToAccount(int id) async {
  try {
    await  FirebaseFirestore.instance.collection('users').doc('me').update({
      'courses': FieldValue.arrayUnion([id]) 
    });

    return 200;
  }catch(e){
      return 400;
  }
}
