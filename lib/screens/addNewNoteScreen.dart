import 'package:flutter/material.dart';
import 'package:myNotes/model/notesModel.dart';
import 'package:myNotes/providers/noteStore.dart';
import 'package:provider/provider.dart';

class AddNewNoteScreen extends StatefulWidget {
  @override
  _AddNewNoteScreenState createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  var _editedNote = Note(
    id: null,
    title: '',
    content: '',
  );
  var _initValues = {
    'title': '',
    'content': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final noteId = ModalRoute.of(context).settings.arguments as String;
      if (noteId != null) {
        _editedNote = Provider.of<MyNotes>(context, listen: false)
            .findNoteById(id: noteId);
        _initValues = {
          'title': _editedNote.title,
          'content': _editedNote.content,
        };
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveform() {
    final _isValid = _formKey.currentState.validate();

    if (!_isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedNote.id != null) {
      Provider.of<MyNotes>(context, listen: false)
          .updateExistingNote(id: _editedNote.id, newNote: _editedNote);
    } else {
      Provider.of<MyNotes>(context, listen: false).addNewNotes(_editedNote);
      print('add new note');
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveform,
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  hintText: 'Note title',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedNote = Note(
                    id: _editedNote.id,
                    title: value,
                    content: _editedNote.content,
                  );
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: TextFormField(
                  initialValue: _initValues['content'],
                  maxLines: 1000,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Write your notes here',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter a content or go back';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedNote = Note(
                      id: _editedNote.id,
                      title: _editedNote.title,
                      content: value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
