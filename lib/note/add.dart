import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_application/components/crud.dart';
import 'package:note_application/constants/linksapi.dart';
import 'package:note_application/main.dart';

class add_note extends StatefulWidget {
  const add_note({super.key});

  @override
  State<add_note> createState() => _add_noteState();
}

class _add_noteState extends State<add_note> {
  bool isloading = false;
  final title = TextEditingController();
  final content = TextEditingController();
  late final String? Function(String?) valid;
  GlobalKey<FormState> formstats = GlobalKey();
  late String select;
  bool val = false;
  List chooseitems = ["choose from gallery", "choose from internet"];
  final Crud _crud = Crud();
  File? myfile;

  addthenote() async {
    // ignore: unnecessary_null_comparison
    if (myfile == null) {
      return showDialog(
        context: context,
        builder: (context) {
          String contentText = "الرجاء إضافة الصورة الخاصة بالملاحظة ";
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            icon: const Icon(
              Icons.error,
              size: 50,
              color: Color.fromARGB(255, 235, 142, 2),
            ),
            title: const Center(
              child: Text(
                "هام",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 235, 142, 2),
                ),
              ),
            ),
            content: Text(contentText),
          );
        },
      );
    }
    if (formstats.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await _crud.postRequestwithFile(
          linkadd,
          {
            "title": title.text,
            "content": content.text,
            "id": pref.getString('id')
          },
          myfile!);
      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add note"),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
      ),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 235, 142, 2),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
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
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => SizedBox(
                                            height: 120,
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "please choose photo",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                          "from gallery",
                                                          style: TextStyle(
                                                              fontSize: 20))),
                                                  onTap: () async {
                                                    XFile? xfile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                    myfile = File(xfile!.path);
                                                  },
                                                ),
                                                InkWell(
                                                  child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                          "from Camera",
                                                          style: TextStyle(
                                                              fontSize: 20))),
                                                  onTap: () async {
                                                    XFile? xfile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
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
                                            ? const Color.fromARGB(
                                                255, 235, 142, 2)
                                            : const Color.fromRGBO(
                                                235, 177, 2, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 15,
                                        bottom: 15)),
                                child: const Text(
                                  "choose photo",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await addthenote();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 235, 142, 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding: const EdgeInsets.only(
                                        left: 60,
                                        right: 60,
                                        top: 15,
                                        bottom: 15)),
                                child: const Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))),
            ),
    );
  }
}
