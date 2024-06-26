
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_course/core/services/fast_search_service.dart';
import 'package:online_course/src/features/chat/presentation/pages/chat/widgets/chat_appbar.dart';
import 'package:online_course/src/features/chat/presentation/pages/chat/widgets/chat_search_block.dart';
import 'package:online_course/src/features/chat/presentation/pages/chat/widgets/notes_item.dart';
import 'package:online_course/src/features/course/data/models/notes_model.dart';
import 'package:online_course/src/features/course/pesentation/pages/explore/widgets/explore_category.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool showUnlockButton = true;
  
  String searchTxt = "";
  String selectedCategory= "";// Set this to false when the user upgrades
  List<NotesModel> notesList = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ChatAppBar(),
            const SizedBox(height: 16),
             ChatSearchBlock(onSearch: (String s) async{ 
                print(s);
                    searchTxt = s;
                   fetchNotes();
             },),
            const SizedBox(height: 16),
             const SizedBox(height: 10),
            ExploreCategory(onCategorySelected: (String c) {
              setState(() {
                selectedCategory = c;
              });
               fetchNotes();
              },),
            Expanded(
              child:ListView.builder(
                      itemCount: notesList.length ?? 0,
                      itemBuilder: (context, index) {
                        return NotesItem(notes: notesList[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}
// Method to fetch notes from the 'pyq' collection in Firestore
Future<List<NotesModel>> fetchNotes() async {
  List<NotesModel> noteList = [];

  try {
    // Get a reference to the 'pyq' collection
    Query query =  FirebaseFirestore.instance.collection('pyq');


    if(searchTxt.isNotEmpty){
              try {
        var docIds = await getDocIdsBySearchTerm(searchTxt,'notes');

        if (docIds.isNotEmpty) {
          query =
              query.where(FieldPath.documentId, whereIn: docIds);
        } else {}
      } catch (e) {
        if (kDebugMode) {
          print('search error $e');
        }
      }  
    }else if(selectedCategory.isNotEmpty){
      query = query.where('tags', arrayContains: selectedCategory);
    }


    QuerySnapshot<Object?> querySnapshot =await query.orderBy('timestamp').limit(100).get() ;
    // Iterate through the documents in the collection
    for (var doc in querySnapshot.docs) {
      // Extract data from each document and create a NotesModel object
      NotesModel note = NotesModel(
        title: doc['title'],
        subtitle: doc['subtitle'],
        url: doc['url'],
        timestamp: doc['timestamp'] as Timestamp,
      );
      noteList.add(note);
    }
  } catch (e) {
    // Handle any errors that occur during the fetch operation
    if (kDebugMode) {
      print('Error fetching notes: $e');
    }
    // You can throw the error here if you want to handle it elsewhere
    // throw e;
  }

  notesList= noteList;
  setState(() {});
  return notesList;
}

    // return Stack(
    //   children: [
    //     // Blur effect
    //     Positioned.fill(
    //       child: BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    //         child: CustomScrollView(
    //           slivers: <Widget>[
    //             const SliverAppBar(
    //               backgroundColor: Color.fromARGB(162, 247, 247, 247),
    //               pinned: true,
    //               snap: true,
    //               floating: true,
    //               title: ChatAppBar(),
    //             ),
    //             const SliverToBoxAdapter(
    //               child: ChatSearchBlock(),
    //             ),
    //             SliverToBoxAdapter(
    //               child: ChatRecentChatList(chats: chats),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     // "Upgrade to Unlock" button
    //     if (showUnlockButton)
    //       Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text(
    //               'BhaaratCore Softwares',
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 24.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             const SizedBox(height: 20.0),
    //             ElevatedButton(
    //               onPressed: () {
    //                 // Handle upgrade button press
    //               },
    //               child: Text('Upgrade app to Unlock chat features'),
    //             ),
    //           ],
    //         ),
    //       ),
    //   ],
    // );
  }

