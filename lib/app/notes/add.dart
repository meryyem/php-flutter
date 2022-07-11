import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phpfluttercourse/component/crud.dart';
import 'package:phpfluttercourse/component/customTextForm.dart';
import 'package:phpfluttercourse/component/valid.dart';
import 'package:phpfluttercourse/constant/linkapi.dart';
import 'package:phpfluttercourse/main.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  File? myFile;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  addNotes() async {
    if (myFile == null)
      return AwesomeDialog(
          context: context,
          title: "required !!",
          body: Text("please upload an image"));
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            //this is the user id
            "id": sharedP.getString("id"),
          },
          myFile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Notes")),
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
                                            Navigator.of(context).pop();
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
                                            Navigator.of(context).pop();
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
                          await addNotes();
                        },
                        child: Text("Add"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
