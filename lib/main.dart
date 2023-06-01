import 'package:mr_museum/screens/stream2.dart';
import 'package:universal_io/io.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mr_museum/screens/selected_headset_page.dart';
import 'package:mr_museum/screens/add_headset.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:mr_museum/screens/app_dashboard.dart';
import 'package:mr_museum/screens/authorization_page.dart';
import 'package:mr_museum/screens/headset_dashboard.dart';
import 'package:mr_museum/screens/settingsPage.dart';
import 'functions/firebase_auth.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MR Museum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

PageController page = PageController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //page.jumpToPage(3);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        page.jumpToPage(3);
      } else {
        page.jumpToPage(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        SideMenu(
          controller: page,
          style: SideMenuStyle(
            // showTooltip: false,

            displayMode: SideMenuDisplayMode.auto,
            itemBorderRadius: BorderRadius.all(Radius.circular(15)),
            //hoverColor: Color.fromARGB(255, 186, 219, 230),
            selectedColor: Colors.white,
            unselectedTitleTextStyle: const TextStyle(color: Colors.black),
            selectedTitleTextStyle: const TextStyle(color: Colors.black),
            selectedIconColor: Color.fromARGB(255, 0, 0, 0),
            itemOuterPadding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
            decoration: BoxDecoration(border: Border(), boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.1))
            ]),
            backgroundColor: Colors.white,
          ),
          title: (Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 150,
                  maxWidth: 150,
                ),
                child: Image.asset(
                  'lib/assets/images/logo-transparent.png',
                ),
              ),
              const Divider(
                indent: 8.0,
                endIndent: 8.0,
              ),
            ],
          )),
          footer: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ElevatedButton(
                onPressed: () async {
                  signOut();
                },
                child: Text('Sign out')),
          ),
          items: [
            SideMenuItem(
              icon: const Icon(Icons.headset_mic),
              priority: 0,
              title: 'Devices',
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  page.jumpToPage(0);
                } else {
                  page.jumpToPage(3);
                }
              },
            ),
            SideMenuItem(
              icon: const Icon(Icons.games),
              priority: 1,
              title: 'Exhibitions',
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  page.jumpToPage(1);
                } else {
                  page.jumpToPage(3);
                }
              },
            ),
            SideMenuItem(
              icon: const Icon(Icons.settings),
              priority: 2,
              title: 'Settings',
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  //page.jumpToPage(6);
                } else {
                  page.jumpToPage(3);
                }
              },
            ),
            /* SideMenuItem(
              icon: const Icon(Icons.settings),
              priority: 3,
              title: 'Auth',
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  page.jumpToPage(3);
                } else {
                  page.jumpToPage(3);
                }
              },
            )*/
          ],
        ),
        Expanded(
            child: PageView(
          controller: page,
          children: [
            HeadsetDashboard(),
            AppDashboard(),
            SettingsPage(),
            AuthorizationPage(),
            SelectedHeadset(),
            AddHeadset(),
            StreamTest(),
          ],
        ))
      ],
    ));
  }
}
