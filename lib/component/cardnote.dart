import 'package:flutter/material.dart';
import 'package:phpfluttercourse/constant/linkapi.dart';
import 'package:phpfluttercourse/model/note_model.dart';

class CardNotes extends StatelessWidget {
  final void Function() onTapNote;
  final void Function() onDelete;
  //final String title;
  //final String content;
  final NoteModel noteModel;
  const CardNotes({
    Key? key,
    required this.onTapNote,
    //required this.title,
    //required this.content,
    required this.noteModel,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapNote,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                  "$linkImageRoot/${noteModel.notesImage}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            Expanded(
              flex: 2,
              child: ListTile(
                //title: Text("$title"),
                //subtitle: Text("$content"),
                title: Text("${noteModel.notesTitle}"),
                subtitle: Text("${noteModel.notesContent}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//remarque a revoir a video 28 => 3.32
