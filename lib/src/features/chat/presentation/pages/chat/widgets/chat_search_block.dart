import 'package:flutter/material.dart';
import 'package:online_course/src/theme/app_color.dart';
import 'package:online_course/src/widgets/custom_textfield.dart';

class ChatSearchBlock extends StatefulWidget {

  final Function(String) onSearch;

  const ChatSearchBlock({super.key, required this.onSearch});

  @override
  State<ChatSearchBlock> createState() => _ChatSearchBlockState();
}

class _ChatSearchBlockState extends State<ChatSearchBlock> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SearchBar(
        backgroundColor: const WidgetStatePropertyAll(AppColor.bg_dark),
        elevation: const WidgetStatePropertyAll(0),
        controller: _searchController,
        hintText: "Search question sets",
        hintStyle: const WidgetStatePropertyAll(TextStyle(color: AppColor.labelColor)),
        onSubmitted: (value) {
           widget.onSearch(_searchController.text);
           print(_searchController.text);
        },
  
      
      ),
    );
  }
}
