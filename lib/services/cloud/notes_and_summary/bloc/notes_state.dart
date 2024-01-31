import 'package:flutter/material.dart';

@immutable
abstract class NotesState {
  final bool isLoading;
  final String loadingText;
  const NotesState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class NotesStateUnInitialized extends NotesState {
  NotesStateUnInitialized({required super.isLoading});
}

class NoteStateCreateOrUpdateNote extends NotesState {
  const NoteStateCreateOrUpdateNote({required super.isLoading});
}

class NoteStateViewAllNotes extends NotesState {
  const NoteStateViewAllNotes({required super.isLoading});
}
