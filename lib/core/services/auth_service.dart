
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  User? user = FirebaseAuth.instance.currentUser;
   
   static User? getUser(){
    
        return FirebaseAuth.instance.currentUser;
    
   }

    Future<void> signOutUser(VoidCallback onSignOut) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      //  var cookie = Cookie.create();

      // cookie.remove('drid');
      onSignOut();
      if (kDebugMode) {
        print("User signed out successfully.");
      }
      // Remove all previous routes and navigate to the login page
    
    } catch (error) {
      if (kDebugMode) {
        print("Error signing out: $error");
      }
    }
  }

  Future<User?> signInwithGoogle() async{
     FirebaseAuth auth = FirebaseAuth.instance;
    try {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      if(kIsWeb){
      await auth.signInWithPopup(authProvider);

      }else {
             // await auth.signInWithProvider(authProvider);
             final GoogleSignIn googleSignIn = GoogleSignIn();

             final GoogleSignInAccount? googleSignInAccount =
             await googleSignIn.signIn();

             if (googleSignInAccount != null) {
               final GoogleSignInAuthentication googleSignInAuthentication =
               await googleSignInAccount.authentication;

               final AuthCredential credential = GoogleAuthProvider.credential(
                 accessToken: googleSignInAuthentication.accessToken,
                 idToken: googleSignInAuthentication.idToken,
               );

               try {
                 final UserCredential userCredential =
                 await auth.signInWithCredential(credential);

                 user = userCredential.user;
               }catch(err){
                 print('sign in error $err');
               }
               }
             }
 
     
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return auth.currentUser;
  }

// Future<bool> checkDevice(User? user) async {
//     var cookie = Cookie.create();

//     var value = cookie.get('drid');
    
//     if (value == null || value.isEmpty) {
//       return false;
//     } else {
//       DataSnapshot snapshot = await FirebaseDatabase.instance
//           .ref('userData/${user!.uid}/devices')
//           .child('web')
//           .get();

//       if (snapshot.value != null) {
//         String drid = snapshot.value.toString();
        
//         if (value == drid) {
//          return true;
//         } else {
//           return false;
//         }
//       } else {
//         return false;
//       }
      
//     }
//   }

}