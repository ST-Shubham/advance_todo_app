import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/cloud/notes_and_summary/bloc/notes_event.dart';
import 'package:todo_app/services/cloud/notes_and_summary/bloc/notes_state.dart';
import 'package:todo_app/services/cloud/notes_and_summary/firebase_cloud_storage.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc(FirebaseCloudStorage _notesService)
      : super(
          NotesStateUnInitialized(isLoading: true),
        ) {
    on<NotesEventInitialize>((event, emit) {});
    on<NotesEventGetAllNotes>((event, emit) {});
    on<NotesEventDeleteNote>((event, emit) {});
    on<NotesEventGetNote>((event, emit) {});
    on<NotesEventNewNote>((event, emit) {});
    on<NotesEventUpdateNote>((event, emit) {});
  }
}
