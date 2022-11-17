import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  double? height;
  double? width;

  @override
  void didChangeDependencies() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<Widget> screens = [
    Container(color: Colors.white),
    Container(color: Colors.white),
    Container(color: Colors.white),
    Container(color: Colors.white)
  ];

  int selectedItem = 2;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: SizedBox(
                        height: height! * 0.25,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            buildQrCodeView(context),
                            // Positioned(top: 10, child: buildControllButtons()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: height! * 0.2,
                      child: Column(
                        children: [
                          Flexible(
                            flex:8,
                            child: Padding(
                                padding:  EdgeInsets.all(height!/40),
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: height! / 16,
                                      child: TextField(
                                        readOnly: true,
                                        textAlign: TextAlign.center,
                                        autofocus: barcode == null,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black12),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            labelText: 'بارکد',
                                            hintText: barcode != null
                                                ? ' ${barcode!.code}'
                                                : 'بارکد را اسکن کنید',
                                            hintStyle:const TextStyle(letterSpacing: 1,fontSize:16,fontWeight: FontWeight.bold),
                                            hintTextDirection: TextDirection.rtl),
                                      ),
                                    ))),
                          ),
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.lightBlue[500]),
                                      backgroundColor: MaterialStateProperty.all(
                                          Colors.blue[800]),
                                    ),
                                    child: const Text('بررسی',style: TextStyle(fontSize: 16),),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                      height: height!*0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            infoData('کالا', 'رب مهرام'),
                            infoData('قیمت مصوب', '12,500تومان'),
                            infoData('قیمت تولید کننده', '18,500تومان'),
                            infoData('قیمت مصرف کننده', '19,500تومان'),
                            const Spacer(),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          bottomNavigationBar: CircleBottomNavigationBar(
            initialSelection: selectedItem,
            circleColor: Colors.indigo[500],
            activeIconColor: Colors.white,
            inactiveIconColor: Colors.black45,
            barHeight: 80,
            circleOutline: -30,
            iconYAxisSpace: -15,
            itemTextOn: 0.5,
            itemTextOff: 0.5,
            itemIconOn: -1,
            arcHeight: 200,
            textYAxisSpace: -15,
            hasElevationShadows: false,
            blurShadowRadius: 0,


            tabs: [
              TabData(
                  icon: Icons.layers,
                  title: 'شکایت',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              TabData(
                  icon: Icons.insert_drive_file,
                  title: 'قیمت کالا',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              TabData(
                  icon: Icons.home,
                  title: 'صفحه اصلی',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              TabData(
                  icon: Icons.image,
                  title: 'صدای من',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              TabData(
                  icon: Icons.menu,
                  title: 'منو',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ],
            onTabChangedListener: (index) {
              setState(() {
                selectedItem = index;
              });
            },
          )),
    );
  }

  Row infoData(String title, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        const SizedBox(width: 60),
        Expanded(
            child: Text(
          details,
          style: const TextStyle(color: Colors.black45),
        ))
      ],
    );
  }

  buildQrCodeView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          borderColor: const Color(0xFF1565C0),
          cutOutWidth: MediaQuery.of(context).size.width * 0.8,
          cutOutHeight: MediaQuery.of(context).size.height * 0.15,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) => setState(() {
          this.barcode = barcode;
          if (barcode.code.toString().substring(0, 5) == 'https') {
            _launchUrl(Uri.parse(barcode.code.toString()));
          }
        }));
  }
}

Future<void> _launchUrl(Uri uri) async {
  if (await launchUrl(uri)) {
    throw 'Could not launch $uri';
  }
  // await launchUrl(uri);
}
