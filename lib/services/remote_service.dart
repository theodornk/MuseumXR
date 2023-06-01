// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
//import 'dart:io';

import 'package:mr_museum/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mr_museum/models/ipd.dart';
import 'package:mr_museum/models/machineName.dart';
import 'package:mr_museum/models/power.dart';

var cookieh2 = '';

class RemoteService {
  Future<Powerstatus> getBattery(ip, username, password) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    final response = await http.get(
      Uri.parse('https://' + ip + '/api/power/battery'),
      headers: <String, String>{
        'authorization': basicAuth,
        "Access-Control-Allow-Origin": 'https://' + ip,
        "Access-Control-Allow-Crendetials": "true",
        "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
        "Access-Control-Allow-Headers":
            "Origin, X-Requested-With, Content-Type, Accept, Authorization",
      },
    );

    if (response.statusCode == 200) {
      print(response.headers.toString());
      print(response.headers['set-cookie']);
      return powerstatusFromJson(response.body);
    } else {
      throw Exception('Failed to load battery status');
    }
  }

  Future<IPDStatus> getIPD(ip, username, password) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    final response = await http.get(
      Uri.parse('https://' + ip + '/api/holographic/os/settings/ipd'),
      headers: <String, String>{
        'authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      return ipdstatusFromJson(response.body);
    } else {
      throw Exception('Failed to load ipd status');
    }
  }

  Future<IPDStatus> postIPD(ip, username, password, ipd) async {
    //TODO: Sjekk responsen, sjekk om 200 respons er riktig respons og om det stemmer å bruke fromjson etterpå
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    final response = await http.post(
        Uri.parse('https://' + ip + '/api/holographic/os/settings/ipd'),
        headers: <String, String>{
          'authorization': basicAuth,
        },
        body: jsonEncode(<String, int>{"ipd": ipd}));

    if (response.statusCode == 200) {
      return ipdstatusFromJson(response.body);
    } else {
      throw Exception('Failed to load ipd status');
    }
  }

  Future<MachineName> getMachineName(ip, username, password) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    final response = await http.get(
      Uri.parse('https://' + ip + '/api/os/machinename'),
      headers: <String, String>{
        'authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      return machinenameFromJson(response.body);
    } else {
      throw Exception('Failed to load machine name');
    }
  }

  Future<IPDStatus> postMachinename(ip, username, password, machinename) async {
    //TODO: Sjekk responsen, sjekk om 200 respons er riktig respons og om det stemmer å bruke fromjson etterpå
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    final response = await http.post(
        Uri.parse('https://' + ip + '/api/os/machinename'),
        headers: <String, String>{
          'authorization': basicAuth,
          'set-cookie': cookieh2
        },
        body: jsonEncode(<String, String>{
          "name": base64.encode(AsciiEncoder().convert(machinename))
        }));
    if (response.statusCode == 200) {
      return ipdstatusFromJson(response.body);
    } else {
      throw Exception('Failed to load ipd status');
    }
  }

  Future shutdown(ip, username, password) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    final response = await http.post(
      Uri.parse('https://' + ip + '/api/control/shutdown'),
      headers: <String, String>{
        'authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      return machinenameFromJson(response.body);
    } else {
      throw Exception('Failed to load machine name');
    }
  }

  Future getVideo(ip, username, password) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print('1');
    var request = HttpRequest();
    request.open('GET', 'https://' + ip + '/api/holographic/stream/live.mp4');
    request.onProgress.listen((ProgressEvent event) {
      final response = utf8.decode(request.response);
      print(request.readyState);
    });
    request.send();
    await request.onLoadEnd.first;
    print('Response completed: ${request.status}');
    return request.responseText;

    /*final response = await http.get(
      //Uri.parse('https://' + ip + '/api/holographic/stream/live.mp4'),
      //Uri.parse('https://h5p.org/node/569446'),
      //headers: <String, String>{
      //  'authorization': basicAuth,
      //  "Access-Control-Allow-Origin": '*',
     // },
    //);

    if (response.statusCode == 200) {
      print(response);

      return response;
    } else {
      throw Exception('Failed to load video');
    }*/
  }
}
