import 'package:flutter/material.dart';
import 'package:online_course/core/utils/app_navigate.dart';
import 'package:online_course/src/features/course/data/models/course_model.dart';
import 'package:online_course/src/features/course/domain/entities/course.dart';
import 'package:online_course/src/features/course/pesentation/pages/course_detail/course_detail.dart';
import 'package:online_course/src/theme/app_color.dart';
import '../../../../../../widgets/custom_image.dart';

class MyCourseItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         AppNavigator.to(
              context,
              CourseDetailPage(course: data,isPurchased: true),
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
          data.image,
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
                data.name,
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
                backgroundColor: progressColor.withOpacity(.2),
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              )
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildProgressLessonBlock() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         data["completed"],
  //         style: TextStyle(color: progressColor),
  //       ),
  //       Visibility(
  //         visible: data["complete_percent"] < 1,
  //         child: Text(
  //           data["progress"],
  //           style: const TextStyle(color: AppColor.labelColor),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
