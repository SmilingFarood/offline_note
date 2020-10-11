import 'package:flutter/material.dart';
import 'package:myNotes/providers/noteStore.dart';
import 'package:myNotes/screens/addNewNoteScreen.dart';
import 'package:myNotes/screens/homeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyNotes()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigo[200],
        buttonColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {'/addNewNote': (context) => AddNewNoteScreen()},
    );
  }
}
