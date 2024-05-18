import 'package:flutter/material.dart';
import 'package:online_course/core/utils/app_navigate.dart';
import 'package:online_course/src/features/document_viewer/presentation/pdf_viewer.dart';
import 'package:online_course/src/theme/app_color.dart';

import '../../../../../course/data/models/notes_model.dart';

class NotesItem extends StatelessWidget {
  final NotesModel notes;

  const NotesItem({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(
          context,
          PdfViewer(url: notes.url ?? ''),
        );
      },
      child: Card(
        color: AppColor.bg_dark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.picture_as_pdf,color: Color(4293117037),), // PDF icon
              const SizedBox(width: 8), // Add spacing between icon and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notes.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4), // Add spacing between title and subtitle
                    Text(
                      notes.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.labelColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
