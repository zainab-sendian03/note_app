import 'package:flutter/material.dart';
import 'package:note_application/components/crud.dart';
import 'package:note_application/constants/linksapi.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  late final String? Function(String?) valid;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conpassword = TextEditingController();

  GlobalKey<FormState> formstats = GlobalKey();
  bool isloading = false;
  final Crud _crud = Crud();

  signUp() async {
    isloading = true;
    setState(() {});
    if (formstats.currentState!.validate()) {
      var response = await _crud.postrequest(linksignup, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      isloading = false;
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      } else {
        print("signup fail");
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
        title: const Text("Sign Up"),
        backgroundColor: const Color.fromARGB(255, 235, 142, 2),
      ),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 235, 142, 2),
              ),
            )
          : Container(
              color: const Color.fromARGB(255, 253, 246, 236),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView(children: [
                  Form(
                    key: formstats,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (valid) =>
                                      validinput(valid!, 10, 3),
                                  controller: username,
                                  decoration: InputDecoration(
                                      hintText: "User Name",
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 235, 142, 2),
                                            width: 2.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (valid) => validinput(valid!, 30, 10),
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
                            validator: (valid) => validinput(valid!, 12, 8),
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
                            height: 20,
                          ),
                          TextFormField(
                            controller: conpassword,
                            validator: (valid) => validinput(valid!, 12, 8),
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
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
                              await signUp();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 235, 142, 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                padding: const EdgeInsets.only(
                                    left: 60, right: 60, top: 15, bottom: 15)),
                            child: const Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
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
