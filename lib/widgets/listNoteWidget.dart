import 'package:flutter/material.dart';
import 'package:myNotes/providers/noteStore.dart';
import 'package:provider/provider.dart';

class ListNotesWidget extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final Function deleteFunction;
  final GlobalKey itemKey;

  ListNotesWidget({
    this.id,
    this.title,
    this.content,
    this.deleteFunction,
    this.itemKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/addNewNote', arguments: id);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 7.0,
                  vertical: 5.0,
                ),
                child: Card(
                    elevation: 8,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(title),
                                  Text(
                                    content,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              Provider.of<MyNotes>(context, listen: false)
                                  .deleteNote(
                                id: id,
                                title: title,
                                content: content,
                              );
                            },
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
