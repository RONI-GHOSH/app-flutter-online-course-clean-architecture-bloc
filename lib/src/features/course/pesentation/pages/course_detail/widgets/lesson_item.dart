import 'package:flutter/material.dart';
import 'package:online_course/core/utils/app_navigate.dart';
import 'package:online_course/src/features/course/data/models/course_lessons.dart';
import 'package:online_course/src/features/document_viewer/presentation/pdf_viewer.dart';
import 'package:online_course/src/features/video/presentation/screen/video_player.dart';
import 'package:online_course/src/theme/app_color.dart';

import '../../../../../../widgets/custom_image.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({Key? key, required this.data, this.clickable=false, required this.type}) : super(key: key);
  final CourseLessons data;
  final bool clickable;
  final int type;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!clickable) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please purchase the course first"),
            ),
          );
          return;

        }
      if(type==1){
         AppNavigator.to(
              context,
              VideoPlayer(url:data.videoUrl??''),
            );

      }else{
          AppNavigator.to(
              context,
              PdfViewer(url:data.videoUrl??''),
            );
      }


       
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              CustomImage(
                data.image??'',
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
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          color: AppColor.labelColor,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          data.duration,
                          style: const TextStyle(
                              fontSize: 13, color: AppColor.labelColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.labelColor,
                size: 15,
              ),
            ],
          )),
    );
  }
}
