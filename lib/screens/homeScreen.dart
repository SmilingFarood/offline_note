import 'package:flutter/material.dart';
import 'package:myNotes/providers/noteStore.dart';
import 'package:myNotes/screens/addNewNoteScreen.dart';
import 'package:myNotes/screens/drawer.dart';
import 'package:myNotes/widgets/listNoteWidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final noteDisplayData = Provider.of<MyNotes>(context).notes;

    return Scaffold(
      appBar: AppBar(
        title: Text('NotePad'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<MyNotes>(context, listen: false).fetchAndSetNotes(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<MyNotes>(
                    child: Center(
                        child: const Text('You have not added any notes yet')),
                    builder: (ctx, myNotes, ch) => myNotes.notes.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: myNotes.notes.length,
                            itemBuilder: (ctx, i) => ListNotesWidget(
                              id: myNotes.notes[i].id,
                              title: myNotes.notes[i].title,
                              content: myNotes.notes[i].content,
                              // share: myNotes.notes[i].sharePdf,
                            ),
                          ),
                  ),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewNoteScreen(),
              ),
            );
          },
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
