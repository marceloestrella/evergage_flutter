import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:evergage_flutter/evergage_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _evergageFlutterPlugin = EvergageFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      await _evergageFlutterPlugin.viewProduct('20220914', 'Tecate');
      platformVersion = 'todo bien';
    } on PlatformException {
      platformVersion = 'Failed to get initialized.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Response on: $_platformVersion\n'),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.start(
                          'heinekenintlamer', 'development', false);
                      platformVersion = 'todo bien start';
                      log('todo bien start', name: 'EvergageFlutter');
                    } on PlatformException {
                      platformVersion = 'Failed to start.';
                      log('Failed to start', name: 'EvergageFlutter');
                    } catch (e) {
                      platformVersion = e.toString();
                      log('error $e', name: 'EvergageFlutter');
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("start")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.setUser(
                          '20220916', 'mjaime@bnext.mx', 'Marcelo', 'Jaime');
                      platformVersion = 'todo bien setUser';
                    } on PlatformException {
                      platformVersion = 'Failed to setUser.';
                    } catch (e) {
                      platformVersion = e.toString();
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("setUser")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.setZipCode('640000');
                      platformVersion = 'todo bien setZipCode';
                    } on PlatformException {
                      platformVersion = 'Failed to setZipCode.';
                    } catch (e) {
                      platformVersion = e.toString();
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("setZipCode")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.viewProduct(
                          '20220914', 'Tecate');
                      platformVersion = 'todo bien viewProduct';
                    } on PlatformException {
                      platformVersion = 'Failed to viewProduct.';
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("viewProduct")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.viewCategory(
                          '20220914', 'Cerveza');
                      platformVersion = 'todo bien viewCategory';
                    } on PlatformException {
                      platformVersion = 'Failed to viewCategory.';
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("viewCategory")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.addToCart(
                          '20220914', 'Tecate 1', 2, 18);
                      platformVersion = 'todo bien addToCart';
                    } on PlatformException {
                      platformVersion = 'Failed to addToCart.';
                    } catch (e) {
                      platformVersion = e.toString();
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("addToCart")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      const listItem =
                          '{"list":[{"id":"1998","name":"coco-light","price":25.4,"quantity":2}]}';

                      await _evergageFlutterPlugin.purchase(
                          '20220914', listItem, 200);

                      platformVersion = 'todo bien purchase';
                    } on PlatformException {
                      platformVersion = 'Failed to purchase.';
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("purchase")),
              ElevatedButton(
                  onPressed: () async {
                    String platformVersion;

                    try {
                      await _evergageFlutterPlugin.login();
                      platformVersion = 'todo bien login';
                    } on PlatformException {
                      platformVersion = 'Failed to login.';
                    } catch (e) {
                      platformVersion = e.toString();
                    }

                    setState(() {
                      _platformVersion = platformVersion;
                    });
                  },
                  child: const Text("login")),
            ],
          ),
        ),
      ),
    );
  }
}
