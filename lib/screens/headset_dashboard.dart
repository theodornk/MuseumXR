import 'dart:io';
import 'package:mr_museum/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mr_museum/models/headsets.dart';
import 'package:mr_museum/models/power.dart';
import 'package:mr_museum/services/database.dart';
import 'package:mr_museum/services/remote_service.dart';

class HeadsetDashboard extends StatefulWidget {
  const HeadsetDashboard({super.key});

  @override
  State<HeadsetDashboard> createState() => _HeadsetDashboardState();
}

List<Headsets> headsets = [];
var selectedHeadset;

class _HeadsetDashboardState extends State<HeadsetDashboard> {
  List batteryLevel = [];

  @override
  void initState() {
    getHeadsets();
    super.initState();
  }

  getData(ip, username, password, i) async {
    print('getData Called');
    //NOTE: Fjernet placeholder verdi til Powerstatus for å få det til å se bedre ut, sjekk forrige commit for å se hvordan det var før
    try {
      var batterylevel =
          (await RemoteService().getBattery(ip, username, password));
      setState(() {
        headsets[i].batteryLevel = (batterylevel.remainingCapacity /
                batterylevel.maximumCapacity *
                100)
            .ceil();
      });
    } catch (e) {
      print(e);
    }
    try {
      var ipdlevel = (await RemoteService().getIPD(ip, username, password));
      headsets[i].ipdLevel = ipdlevel.ipd;
    } catch (e) {
      print(e);
    }

    try {
      var machinename =
          (await RemoteService().getMachineName(ip, username, password));
      headsets[i].name = machinename.computername;
    } catch (e) {
      print(e);
    }
  }

  getHeadsets() async {
    var updatedHeadsets = await DatabaseService().getHeadsets();
    for (var i = 0; i < updatedHeadsets.length; i++) {
      getData(updatedHeadsets[i].ip, updatedHeadsets[i].username,
          updatedHeadsets[i].password, i);
    }
    setState(() {
      headsets = updatedHeadsets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 500,
                            childAspectRatio: 1,
                            crossAxisSpacing: 50,
                            mainAxisSpacing: 50),
                    itemCount: headsets.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return SizedBox(
                        child: Opacity(
                          opacity: headsets[index].batteryLevel == 0 ? 0.45 : 1,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.white,
                            elevation: 5,
                            child: InkWell(
                              onTap: headsets[index].batteryLevel == 0
                                  ? () {
                                      /*page.jumpToPage(4);
                                      setState(() {
                                        selectedHeadset = headsets[index];
                                      });*/
                                    } //null
                                  : () {
                                      page.jumpToPage(4);
                                      setState(() {
                                        selectedHeadset = headsets[index];
                                      });
                                    },
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "lib/assets/images/hololens.png"),
                                        fit: BoxFit.scaleDown)),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Text(headsets[index].name,
                                          style: TextStyle(fontSize: 20)),
                                    )),
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                headsets[index].batteryLevel >
                                                        20
                                                    ? Icon(
                                                        Icons.battery_full,
                                                        color: Colors.green,
                                                      )
                                                    : (headsets[index]
                                                                .batteryLevel
                                                                .toString() ==
                                                            '0')
                                                        ? Icon(
                                                            Icons.battery_0_bar)
                                                        : Icon(
                                                            Icons.battery_alert,
                                                            color: Colors.red,
                                                          ),
                                                (headsets[index]
                                                            .batteryLevel
                                                            .toString() ==
                                                        '0')
                                                    ? Text('Off')
                                                    : Text(headsets[index]
                                                            .batteryLevel
                                                            .toString() +
                                                        '%')
                                              ],
                                            ),
                                            (headsets[index]
                                                        .batteryLevel
                                                        .toString() ==
                                                    '0')
                                                ? Icon(Icons.wifi_off)
                                                : Icon(
                                                    Icons.wifi,
                                                    color: Colors.blue,
                                                  ),
                                            (headsets[index]
                                                        .batteryLevel
                                                        .toString() ==
                                                    '0')
                                                ? Icon(
                                                    Icons.power_settings_new,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.power_settings_new,
                                                    color: Colors.green,
                                                  ),
                                          ]),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
          Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: ElevatedButton(
                    onPressed: () {
                      page.jumpToPage(5);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          Text('Add new headset'),
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
