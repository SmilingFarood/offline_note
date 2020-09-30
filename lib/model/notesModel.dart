import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String content;
  Key key;

  Note({
    this.id,
    this.title,
    this.content,
    this.key,
  });
}
