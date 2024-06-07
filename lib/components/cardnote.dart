// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:note_application/constants/linksapi.dart';
import 'package:note_application/model/note_model.dart';

class card_note extends StatelessWidget {
  final void Function()? ontap;
  note_model notemodel;
  final void Function()? onDlete;

  card_note({
    Key? key,
    required this.ontap,
    required this.notemodel,
    required this.onDlete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: ontap,
        child: Card(
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkimageroot/${notemodel.noteImage}",
                height: 150,
                width: 300,
              ),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    "${notemodel.noteTitle}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${notemodel.noteContent}",
                      style: const TextStyle(
                        fontSize: 17,
                      )),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDlete,
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
