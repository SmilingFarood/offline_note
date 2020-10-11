import 'package:flutter/cupertino.dart';
import 'package:myNotes/model/notesModel.dart';

import '../helpers/db_helpers.dart';

class MyNotes with ChangeNotifier {
  List<Note> _notes = [
    // Note(
    //   id: 'n1',
    //   title: 'Title',
    //   content:
    //       'Ut lectus arcu bibendum at varius. Aliquam id diam maecenas ultricies mi eget mauris pharetra. Orci eu lobortis elementum nibh tellus molestie nunc non. Et molestie ac feugiat sed lectus vestibulum mattis. Massa ultricies mi quis hendrerit dolor. Amet commodo nulla facilisi nullam vehicula ipsum a. Nam libero justo laoreet sit amet cursus sit amet dictum. Facilisi etiam dignissim diam quis. Hendrerit gravida rutrum quisque non tellus orci ac. Leo in vitae turpis massa sed. Sit amet nisl purus in mollis nunc. Netus et malesuada fames ac turpis egestas maecenas pharetra convallis. Vel pretium lectus quam id. Dictum fusce ut placerat orci nulla pellentesque dignissim enim. Morbi tincidunt augue interdum velit euismod in pellentesque massa. Mauris in aliquam sem fringilla. Etiam erat velit scelerisque in dictum non consectetur. Aliquet porttitor lacus luctus accumsan.',
    // ),
    // Note(
    //   id: 'n2',
    //   title: 'Title',
    //   content:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ipsum nunc aliquet bibendum enim. Donec ac odio tempor orci dapibus ultrices in. Lectus nulla at volutpat diam ut. Fermentum dui faucibus in ornare quam viverra orci. At varius vel pharetra vel. Interdum velit laoreet id donec ultrices tincidunt. Cras semper auctor neque vitae tempus quam pellentesque. Phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis. Montes nascetur ridiculus mus mauris vitae ultricies leo. Faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae. Tempus urna et pharetra pharetra massa massa ultricies. Dignissim sodales ut eu sem integer. Pellentesque sit amet porttitor eget dolor morbi. Amet aliquam id diam maecenas ultricies.',
    // ),
  ];

  List<Note> get notes {
    return [..._notes];
  }

  void addNewNotes(Note note) {
    //NOTE: Add note
    final newNote = Note(
      title: note.title,
      content: note.content,
      id: DateTime.now().toIso8601String(),
    );
    _notes.insert(0, newNote);
    notifyListeners();
    DBHelper.insert(table: 'user_notes', data: {
      'id': newNote.id,
      'title': newNote.title,
      'content': newNote.content,
    });
    DBHelper.closeDB();
  }

  Future<void> fetchAndSetNotes() async {
    final noteList = await DBHelper.getData(table: 'user_notes');
    _notes = noteList
        .map((item) => Note(
              id: item['id'],
              title: item['title'],
              content: item['content'],
            ))
        .toList();
    notifyListeners();
    DBHelper.closeDB();
  }

  Note findNoteById({String id}) {
    return _notes.firstWhere((element) => element.id == id);
  }

  Future<void> updateExistingNote({String id, Note newNote}) async {
    final noteIndex = _notes.indexWhere((element) => element.id == id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = newNote;
      notifyListeners();
      await DBHelper.updateData(
        table: 'user_notes',
        values: {
          'id': newNote.id,
          'title': newNote.title,
          'content': newNote.content,
        },
        id: id,
      );
      DBHelper.closeDB();
    } else {
      print('...');
    }
  }

  Future<void> deleteNote({
    String id,
  }) async {
    _notes.removeWhere((element) => element.id == id);
    notifyListeners();
    await DBHelper.deleteNoteData(
      table: 'user_notes',
      id: id,
    );
    DBHelper.closeDB();
  }
}
