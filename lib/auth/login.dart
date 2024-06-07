import 'package:flutter/material.dart';
import 'package:note_application/components/crud.dart';
import 'package:note_application/constants/linksapi.dart';
import 'package:note_application/main.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginstate();
}

class _loginstate extends State<login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final Crud crud = Crud();
  bool isloading = true;
  GlobalKey<FormState> formstats = GlobalKey();
  late final String? Function(String?) valid;

  loogIn() async {
    if (formstats.currentState!.validate()) {
      var response = await crud.postrequest(
          linklogin, {"email": email.text, "password": password.text});
      if (response != null && response['status'] == "success") {
        pref.setString("id", response['data']['id'].toString());
        pref.setString("email", response['data']['email']);
        pref.setString("username", response['data']['username']);

        Navigator.of(context).pushNamed("/home");
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            String contentText =
                "كلمة السر او الحساب الالكتروني خطأ او الحساب غير موجود ";
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              icon: const Icon(
                Icons.error,
                size: 50,
                color: Color.fromARGB(255, 235, 142, 2),
              ),
              title: const Center(
                child: Text(
                  "تنبيه",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 235, 142, 2),
                  ),
                ),
              ),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 235, 142, 2),
                      )),
                ),
              ],
            );
          },
        );
      }
    }
  }

  validinput(String val, int max, int min) {
    if (val.length > max) {
      return " $max لا يمكن ان يكون هذا الحقل اكبر من";
    }
    if (val.isEmpty) {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    if (val.length < min) {
      return "$min لا يمكن ان يكون هذا الحقل اصغر من";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
      ),
      body: Container(
        color: const Color.fromARGB(255, 253, 246, 236),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(children: [
            Form(
              key: formstats,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "asset/icon.png",
                      width: 700,
                      height: 300,
                    ),
                    TextFormField(
                      validator: (valid) => validinput(valid!, 20, 10),
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (valid) => validinput(valid!, 20, 8),
                      decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                      height: 23,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await loogIn();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 235, 142, 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 15, bottom: 15)),
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pushNamed("/signup");
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 60, right: 60, top: 15, bottom: 15)),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 235, 142, 2),
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
