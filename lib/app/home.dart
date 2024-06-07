import 'package:flutter/material.dart';
import 'package:note_application/components/cardnote.dart';
import 'package:note_application/constants/linksapi.dart';
import 'package:note_application/main.dart';
import 'package:note_application/model/note_model.dart';
import 'package:note_application/note/edit.dart';
import '../components/crud.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Crud _crud = Crud();
  Future<dynamic> getNotes() async {
    var response =
        await _crud.postrequest(linkveiw, {"id": pref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Application"),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        actions: [
          IconButton(
              onPressed: () {
                pref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 253, 246, 236),
        child: ListView(children: [
          FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshote) {
                if (snapshote.hasData) {
                  if (snapshote.data['status'] == 'fail') {
                    return const Center(
                      child: Text("there are no notes",
                          style: TextStyle(fontSize: 15)),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshote.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return card_note(
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => edit_note(
                                    note: snapshote.data['data'][i])));
                          },
                          notemodel:
                              note_model.fromJson(snapshote.data['data'][i]),
                          onDlete: () async {
                            var response = await _crud.postrequest(linkdelete, {
                              "id": snapshote.data['data'][i]['note_id']
                                  .toString(),
                              "imagename": snapshote.data['data'][i]
                                      ['note_image']
                                  .toString(),
                            });
                            if (response['status'] == "success") {
                              setState(() {});
                              Navigator.of(context)
                                  .pushReplacementNamed("/home");
                            }
                          },
                        );
                      });
                }
                if (snapshote.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text('just wait a minute...',
                        style: TextStyle(fontSize: 20)),
                  );
                }
                return const Center(
                  child: Text('is loading...', style: TextStyle(fontSize: 20)),
                );
              })
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add");
        },
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
