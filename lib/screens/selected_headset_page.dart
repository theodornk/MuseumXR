import 'package:flutter/material.dart';
import 'package:mr_museum/main.dart';
import 'package:mr_museum/screens/headset_dashboard.dart';
import 'package:mr_museum/screens/stream2.dart';
import 'package:mr_museum/services/remote_service.dart';

class SelectedHeadset extends StatefulWidget {
  String ipd_title = "IPD...";

  SelectedHeadset({super.key});

  @override
  State<SelectedHeadset> createState() => _SelectedHeadsetState();
}

class _SelectedHeadsetState extends State<SelectedHeadset> {
  @override
  bool isReadOnlyI = true;
  bool isReadOnlyN = true;
  TextEditingController _ipdController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  _edit(read) {
    if (read == 'I') {
      setState(() {
        isReadOnlyI = !isReadOnlyI;
      });
    } else {
      setState(() {
        isReadOnlyN = !isReadOnlyN;
      });
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                elevation: 5,
                child: Column(
                  children: [
                    AppBar(
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
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: Column(
                          children: [
                            Text(selectedHeadset.name,
                                style: TextStyle(fontSize: 25)),
                            Text(selectedHeadset.ip,
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text('WiFi',
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 300,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        fixedSize: const Size.fromHeight(50)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 0),
                                                child: Text('eduroam',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 4, 0),
                                                child: Icon(Icons.wifi),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Icon(Icons.arrow_forward),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Text('IPD',
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  //height: 100,
                                  width: 300,
                                  child: Form(
                                    //key: _loginKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          child: TextFormField(
                                            readOnly: isReadOnlyI,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {},
                                            controller: _ipdController,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: isReadOnlyI
                                                          ? Colors.black
                                                          : Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: isReadOnlyI
                                                          ? Colors.black
                                                          : Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                suffixIcon: IconButton(
                                                    color: isReadOnlyI
                                                        ? Colors.black
                                                        : Colors.blue,
                                                    onPressed: () {
                                                      _edit('I');
                                                      isReadOnlyI
                                                          ? RemoteService().postIPD(
                                                              selectedHeadset
                                                                  .ip,
                                                              selectedHeadset
                                                                  .username,
                                                              selectedHeadset
                                                                  .password,
                                                              int.parse(
                                                                  _ipdController
                                                                      .text))
                                                          : null;
                                                    },
                                                    icon: isReadOnlyI
                                                        ? Icon(
                                                            Icons.edit_outlined)
                                                        : Icon(Icons.check)),
                                                filled: true,
                                                fillColor: Colors.grey[50],
                                                prefixIcon: Icon(
                                                    color: isReadOnlyI
                                                        ? Colors.black
                                                        : Colors.blue,
                                                    Icons.remove_red_eye),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                hintText: selectedHeadset
                                                    .ipdLevel
                                                    .toString(),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(''),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Text('Navn',
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  //height: 100,
                                  width: 300,
                                  child: Form(
                                    //key: _loginKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          child: TextFormField(
                                            readOnly: isReadOnlyN,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {},
                                            controller: _nameController,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: isReadOnlyN
                                                          ? Colors.black
                                                          : Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: isReadOnlyN
                                                          ? Colors.black
                                                          : Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                suffixIcon: IconButton(
                                                    color: isReadOnlyN
                                                        ? Colors.black
                                                        : Colors.blue,
                                                    onPressed: () {
                                                      _edit('N');
                                                      isReadOnlyN
                                                          ? RemoteService()
                                                              .postMachinename(
                                                                  selectedHeadset
                                                                      .ip,
                                                                  selectedHeadset
                                                                      .username,
                                                                  selectedHeadset
                                                                      .password,
                                                                  _nameController
                                                                      .text)
                                                          : null;
                                                    },
                                                    icon: isReadOnlyN
                                                        ? Icon(
                                                            Icons.edit_outlined)
                                                        : Icon(Icons.check)),
                                                filled: true,
                                                fillColor: Colors.grey[50],
                                                prefixIcon: Icon(
                                                    color: isReadOnlyN
                                                        ? Colors.black
                                                        : Colors.blue,
                                                    Icons.abc),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                hintText: selectedHeadset.name,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 50, 0, 0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                print(selectedHeadset.ip);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StreamTest()));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.view_stream),
                                                    Text('Livestream'),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        /*Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 50, 0, 0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                print(cookieh2);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.view_stream),
                                                    Text('Cookie test'),
                                                  ],
                                                ),
                                              )),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
