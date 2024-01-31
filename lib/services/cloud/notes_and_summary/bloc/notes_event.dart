import 'package:flutter/material.dart';

@immutable
abstract class NotesEvent {
  const NotesEvent();
}

class NotesEventInitialize extends NotesEvent {
  const NotesEventInitialize();
}

class NotesEventNewNote extends NotesEvent {
  final String ownerUserId;
  const NotesEventNewNote({
    required this.ownerUserId,
  });
}

class NotesEventGetNote extends NotesEvent {
  final String ownerUserId;
  const NotesEventGetNote({required this.ownerUserId});
}

class NotesEventDeleteNote extends NotesEvent {
  final String documentId;
  const NotesEventDeleteNote({
    required this.documentId,
  });
}

class NotesEventUpdateNote extends NotesEvent {
  final String documentId;
  final String text;
  final String title;
  const NotesEventUpdateNote({
    required this.documentId,
    required this.text,
    required this.title,
  });
}

class NotesEventGetAllNotes extends NotesEvent {
  final String ownerUserId;
  const NotesEventGetAllNotes({required this.ownerUserId});
}
