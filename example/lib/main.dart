import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/battery_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery Info plugin example'),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<BatteryInfo>(
                  future: BatteryInfoPlugin.batteryInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                          'Battery Level: ${snapshot.data.batteryLevel}');
                    }
                    return CircularProgressIndicator();
                  }),
              StreamBuilder<BatteryInfo>(
                  stream: BatteryInfoPlugin.batteryInfoStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                          'Battery Level: ${(snapshot.data.chargeTimeRemaining / 1000 / 60).truncate()} minutes');
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
