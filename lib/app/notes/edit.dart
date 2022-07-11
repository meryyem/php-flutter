import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phpfluttercourse/component/crud.dart';
import 'package:phpfluttercourse/component/customTextForm.dart';
import 'package:phpfluttercourse/component/valid.dart';

import '../../constant/linkapi.dart';

class EditNotes extends StatefulWidget {
  //to get the information of the note that will be edited => constructor + initial state (function)
  final notes;
  const EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

//mixin to inherit
class _EditNotesState extends State<EditNotes> with Crud {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  File? myFile;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  editNotes() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;

      if (myFile == null) {
        response = await postRequest(
          linkEditNotes,
          {
            "title": title.text,
            "content": content.text,
            //note id because we change the note so the note with id ..
            "id": widget.notes['notes_id'].toString(),
            "imagename": widget.notes['notes_image'].toString(),
          },
        );
      } else {
        response = await postRequestWithFile(
            linkEditNotes,
            {
              "title": title.text,
              "content": content.text,
              //note id because we change the note so the note with id ..
              "id": widget.notes['notes_id'].toString(),
              "imagename": widget.notes['notes_image'].toString(),
            },
            myFile!);
      }
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("error");
      }
    }
  }

//to get the parameters
  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit Notes")),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: formState,
                  child: ListView(
                    children: [
                      CustomTextFormSign(
                          hint: "title",
                          myController: title,
                          valid: (val) {
                            return validInput(val!, 1, 40);
                          }),
                      CustomTextFormSign(
                          hint: "content",
                          myController: content,
                          valid: (val) {
                            return validInput(val!, 10, 255);
                          }),
                      Container(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Choose Image"),
                                      InkWell(
                                          onTap: () async {
                                            XFile? xFile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Navigator.of(context).pop(true);
                                            //dart:io
                                            myFile = File(xFile!.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              child: Text("From Gallery"))),
                                      InkWell(
                                          onTap: () async {
                                            XFile? xFile = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            Navigator.of(context).pop(true);
                                            //dart:io
                                            myFile = File(xFile!.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              child: Text("From Camera")))
                                    ],
                                  )));
                        },
                        child: Text("Choose Image"),
                        textColor: Colors.white,
                        color: myFile == null ? Colors.blue : Colors.green,
                      ),
                      Container(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await editNotes();
                        },
                        child: Text("Save"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
