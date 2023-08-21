

import 'package:firebase_core_dart/firebase_core_dart.dart';

List<Map> task = [];

// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=us&category=business&apiKey=83fd380ce9804557a5a4af8cbd00e346

//     https://newsapi.org/


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String? uId ='';


/*const DefaultFirebaseOptions = FirebaseOptions(
  appId: '...',
  apiKey: '...',
  projectId: '...',
  messagingSenderId: '...',
  authDomain: '...',
);*/

