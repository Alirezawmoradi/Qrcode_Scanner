import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Future scanBarcode() async {
  @override
  Widget build(BuildContext context) {
    SystemChrome. setPreferredOrientations([
      DeviceOrientation. portraitUp,
      DeviceOrientation. portraitDown,
    ]);
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl, // or ltr,
        child: QrCodeScanner(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بارکدخوان'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                if (await Permission.camera.request().isGranted) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext conext) => const QrCodeScanner()));
                } else if (await Permission.camera.isDenied) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: const Text(
                                'برای استفاده از این امکان اجازه استفاده از دوربین را به برنامه بدهید',
                                textAlign: TextAlign.justify,
                              ),
                              actions: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(width: double.infinity),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  openAppSettings();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                    'باز کردن تنظیمات')),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('بیخیال')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]));
                }
              },
              child: const Text('بارکدخوان'),
            ),
          ],
        ),
      ),
    );
  }
}
