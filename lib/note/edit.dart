import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_application/components/crud.dart';
import 'package:note_application/constants/linksapi.dart';

class edit_note extends StatefulWidget {
  final note;
  const edit_note({super.key, this.note});

  @override
  State<edit_note> createState() => _edit_noteState();
}

class _edit_noteState extends State<edit_note> {
  bool isloading = false;
  final title = TextEditingController();
  final content = TextEditingController();
  late final String? Function(String?) valid;
  GlobalKey<FormState> formstats = GlobalKey();
  final Crud _crud = Crud();

  validinput(String val, int max, int min) {
    if (val.isEmpty) {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    if (val.length > max) {
      return " $max لا يمكن ان يكون هذا الحقل اكبر من";
    }
    if (val.length < min) {
      return "$min لا يمكن ان يكون هذا الحقل اصغر من";
    }
  }

  editthenote() async {
    if (formstats.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response;
      if (myfile == null) {
        response = await _crud.postrequest(linkedit, {
          "title": title.text,
          "content": content.text,
          "id": widget.note['note_id'].toString(),
          "imagename": widget.note['note_image'].toString(),
        });
      } else {
        response = await _crud.postRequestwithFile(
            linkedit,
            {
              "title": title.text,
              "content": content.text,
              "id": widget.note['note_id'].toString(),
              "imagename": widget.note['note_image'].toString(),
            },
            myfile!);
      }

      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    title.text = widget.note['note_title'];
    content.text = widget.note['note_content'];
  }

  File? myfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add note"),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: isloading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 235, 142, 2),
                ),
              )
            : Container(
                child: Form(
                    key: formstats,
                    child: ListView(
                      padding:
                          const EdgeInsets.only(top: 25, left: 5, right: 5),
                      children: [
                        TextFormField(
                          validator: (valid) => validinput(valid!, 255, 1),
                          controller: title,
                          decoration: InputDecoration(
                              hintText: "add title",
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 235, 142, 2),
                                    width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (valid) => validinput(valid!, 255, 1),
                          controller: content,
                          decoration: InputDecoration(
                              hintText: "add content",
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 235, 142, 2),
                                    width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          const Text("please choose photo"),
                                          InkWell(
                                            child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                    "from gallery",
                                                    style: TextStyle(
                                                        fontSize: 20))),
                                            onTap: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              Navigator.of(context).pop();
                                              setState(() {});
                                              myfile = File(xfile!.path);
                                            },
                                          ),
                                          InkWell(
                                            child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                child: const Text("from Camera",
                                                    style: TextStyle(
                                                        fontSize: 20))),
                                            onTap: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              Navigator.of(context).pop();
                                              setState(() {});
                                              myfile = File(xfile!.path);
                                            },
                                          )
                                        ],
                                      ),
                                    ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  // ignore: unnecessary_null_comparison
                                  myfile == null
                                      ? const Color.fromARGB(255, 235, 142, 2)
                                      : const Color.fromRGBO(235, 177, 2, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 60, right: 60, top: 15, bottom: 15)),
                          child: const Text(
                            "Edit photo",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await editthenote();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 235, 142, 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 60, right: 60, top: 15, bottom: 15)),
                          child: const Text(
                            "Edit",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ))),
      ),
    );
  }
}
