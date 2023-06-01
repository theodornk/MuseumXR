import 'package:flutter/material.dart';
import 'package:mr_museum/models/exhibitions.dart';
import 'package:mr_museum/services/my_icons_icons.dart';

import '../services/database.dart';

class AppDashboard extends StatefulWidget {
  const AppDashboard({super.key});

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

List<Exhibitions> exhibitions = [];
//var selectedHeadset;

class _AppDashboardState extends State<AppDashboard> {
  @override
  void initState() {
    getExhibitions();
    super.initState();
  }

  getExhibitions() async {
    var updatedExhibitions = await DatabaseService().getExhibitions();
    for (var i = 0; i < updatedExhibitions.length; i++) {}
    setState(() {
      exhibitions = updatedExhibitions;
    });
  }

  Future<void> _toggleExhibitionStatus(Exhibitions exhibition) async {
    print(
        'Toggling exhibition status with ID: ${exhibition.id}'); // Debugging line
    await DatabaseService()
        .updateExhibitionActiveStatus(exhibition.id, !exhibition.active);
    getExhibitions();
  }

  Future<void> _resetExhibition(Exhibitions exhibition) async {
    print('Toggling exhibition status with ID: ${exhibition.id}');
    await DatabaseService().resetExhibition(exhibition.id, !exhibition.reset);
    getExhibitions();
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
                    itemCount: exhibitions.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return SizedBox(
                        child: Opacity(
                          opacity: 1,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.white.withOpacity(0.95),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      opacity: exhibitions[index].active == true
                                          ? 1
                                          : 0.3,
                                      image: AssetImage(
                                          "lib/assets/images/exhibitA.png"),
                                      fit: BoxFit.scaleDown)),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Opacity(
                                      opacity: exhibitions[index].active == true
                                          ? 1
                                          : 0.3,
                                      child: Text(exhibitions[index].name,
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                    child: Row(
                                        mainAxisAlignment:
                                            exhibitions[index].active == true
                                                ? MainAxisAlignment.spaceEvenly
                                                : MainAxisAlignment.center,
                                        children: [
                                          exhibitions[index].active == true
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5)),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1)),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all<double>(5),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white)),
                                                    onPressed: () {
                                                      final snackBar = SnackBar(
                                                          elevation: 50,
                                                          width: 350,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              Text(exhibitions[
                                                                          index]
                                                                      .name +
                                                                  ' was resetted successfully')
                                                            ],
                                                          ));
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                      _resetExhibition(
                                                          exhibitions[index]);
                                                    },
                                                    child: Row(
                                                      children: const [
                                                        Text(
                                                          'Reset   ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                        Icon(MyIcons.arrows_cw,
                                                            size: 20,
                                                            color:
                                                                Colors.black),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1)),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                          double>(5),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white)),
                                              onPressed: () {
                                                final snackBar = SnackBar(
                                                    elevation: 50,
                                                    width: 500,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                          exhibitions[index]
                                                                      .active ==
                                                                  false
                                                              ? exhibitions[
                                                                          index]
                                                                      .name +
                                                                  ' was activated successfully'
                                                              : exhibitions[
                                                                          index]
                                                                      .name +
                                                                  ' was deactivated successfully',
                                                        ),
                                                      ],
                                                    ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                _toggleExhibitionStatus(
                                                    exhibitions[index]);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    exhibitions[index].active ==
                                                            false
                                                        ? 'Activate   '
                                                        : 'Deactivate   ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Icon(
                                                    Icons.power_settings_new,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1)),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                          double>(5),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white)),
                                              onPressed: () {
                                                final snackBar = SnackBar(
                                                    elevation: 50,
                                                    width: 500,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                            'Undo action performed'),
                                                      ],
                                                    ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Undo   ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Icon(MyIcons.ccw,
                                                      size: 20,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
