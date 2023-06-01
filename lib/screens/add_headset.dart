import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mr_museum/main.dart';
import 'package:mr_museum/services/database.dart';

class AddHeadset extends StatefulWidget {
  const AddHeadset({super.key});

  @override
  State<AddHeadset> createState() => _AddHeadsetState();
}

class _AddHeadsetState extends State<AddHeadset> {
  static final GlobalKey<FormState> _addKey = GlobalKey<FormState>();
  var _passwordController = TextEditingController();
  var _usernameController = TextEditingController();
  var _nameController = TextEditingController();
  var _ipController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(150),
      child: ListView(
        children: [
          Container(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              child: Column(
                children: [
                  AppBar(
                    title: Text(
                      'Add headset',
                      style: TextStyle(color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    leading: IconButton(
                        onPressed: ((() => page.jumpToPage(0))),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Center(
                      child: Container(
                        height: 500,
                        width: 300,
                        child: Form(
                          key: _addKey,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 50),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return 'Invalid IP-address';
                                    }
                                  },
                                  controller: _ipController,
                                  cursorColor: Colors.cyan,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                      prefixIcon: Icon(Icons.network_wifi),
                                      labelText: 'IP-address',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintText: "IP-address",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  cursorColor: Colors.cyan,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintText: "Name",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: _usernameController,
                                  cursorColor: Colors.cyan,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'Username',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintText: "Username",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: _passwordController,
                                  cursorColor: Colors.cyan,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                    prefixIcon: Icon(Icons.password),
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(errorMessage),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (_addKey.currentState!.validate()) {
                                        try {
                                          await DatabaseService().addHeadset(
                                              _ipController.text,
                                              _nameController.text,
                                              _usernameController.text,
                                              _passwordController.text);
                                          page.jumpToPage(0);
                                        } catch (e) {
                                          setState(() {
                                            errorMessage = e.toString();
                                          });
                                        }
                                      }
                                    },
                                    child: Text('Add headset')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
