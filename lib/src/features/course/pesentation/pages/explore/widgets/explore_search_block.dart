import 'package:flutter/material.dart';
import 'package:online_course/src/widgets/custom_textfield.dart';
import 'package:online_course/src/widgets/icon_box.dart';
import 'package:online_course/src/theme/app_color.dart';

class ExploreSearchBlock extends StatefulWidget {
   final Function(String) onSearch;

  const ExploreSearchBlock({Key? key, required this.onSearch}) : super(key: key);


  @override
  State<ExploreSearchBlock> createState() => _ExploreSearchBlockState();
}

class _ExploreSearchBlockState extends State<ExploreSearchBlock> {
   late TextEditingController _searchController;
   
   @override
  void initState() {
  
    super.initState();
     _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          const Expanded(
            child: CustomTextBox(
              hint: "Search",
              prefix: Icon(Icons.search,
              
              //  color: Colors.grey
               
               ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            bgColor: AppColor.primary,
            radius: 10,
            onTap: () {
               widget.onSearch(_searchController.text);
            },
            child: const Icon(Icons.search, 
            // color: Colors.white
            
            ),
          )
        ],
      ),
    );
  }
}
