import 'package:flutter/material.dart';
import 'package:phpfluttercourse/app/notes/edit.dart';
import 'package:phpfluttercourse/component/cardnote.dart';
import 'package:phpfluttercourse/main.dart';
import 'package:phpfluttercourse/model/note_model.dart';

import '../component/crud.dart';
import '../constant/linkapi.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

//mixin Crud
class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response = await postRequest(linkViewNotes, {
      //id => everyone get only his notes !!
      "id": sharedP.getString("id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), actions: [
        IconButton(
          onPressed: () {
            sharedP.clear();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("login", (route) => false);
          },
          icon: const Icon(Icons.exit_to_app),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNotes");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail')
                      return Center(
                          child: Text(
                        "no notes !!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            onDelete: () async {
                              var response =
                                  await postRequest(linkDeleteNotes, {
                                "id": snapshot.data['data'][i]['notes_id']
                                    .toString(),
                                "imagename": snapshot.data['data'][i]
                                        ['notes_image']
                                    .toString(),
                              });
                              if (response['status'] == "success") {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            },
                            onTapNote: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotes(
                                      //here i get all the data of the note that will edited
                                      notes: snapshot.data['data'][i])));
                            },
                            noteModel:
                                NoteModel.fromJson(snapshot.data['data'][i]),
                            //title: "${snapshot.data['data'][i]['notes_title']}",
                            //content:"${snapshot.data['data'][i]['notes_content']}",
                          );
                        });
                    //CardNotes(content: "test", title: "test", onTapNote: () {});
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Loading..."));
                  }
                  return const Center(child: Text("Loading..."));
                }),
          ],
        ),
      ),
    );
  }
}
