import 'package:business_management/view/screen/entree_sorties/widget/product_info_formfield.dart';
import 'package:business_management/view/screen/historique/historique_screen.dart';
import 'package:business_management/view/screen/home/home_screen.dart';
import 'package:business_management/view/screen/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class EntreeScreen extends StatefulWidget {
  const EntreeScreen({super.key});

  @override
  State<EntreeScreen> createState() => _EntreeScreenState();
}

class _EntreeScreenState extends State<EntreeScreen> {
  bool _isTextFieldVisible = false;
  int _currentIndex = 0;
  DateTime? selectedDate;
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {"page": HomeScreen(), "title": "Home screen"},
      {"page": HistoriqueScreen(), "title": "Historique screen"},
      {"page": HistoriqueScreen(), "title": "Historique screen"},
      {"page": HistoriqueScreen(), "title": "Historique screen"},
      {"page": SettingScreen(), "title": "setting screen"},
    ];
    super.initState();
  }

  void _showInfoPopup() {
    setState(() {
      _isTextFieldVisible = !_isTextFieldVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    Future<void> scanBarcode() async {
      String barcodeScanRes;

      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        print("++++++++++++++++++++++++++++++++++++++ the barcode is " +
            barcodeScanRes);
        // barcodeScanRes == "8720181114526"
        //     ? _isTextFieldVisible = true
        //     : _isTextFieldVisible = false;
        barcodeScanRes == "8720181114526" || barcodeScanRes == "6133776000616"
            ? showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: ProductInfoFormfield(
                      scanBarcode: scanBarcode,
                      selectDate: _selectDate,
                      selectedDate: selectedDate ?? DateTime.now(),
                      barcode: barcodeScanRes,
                    ),
                  );
                })
            : null;
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      if (!mounted) return;

      setState(() {});
    }

    return Scaffold(
      body: _pages[_currentIndex]["page"] as Widget,
      // Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Visibility(
      //             visible: _isTextFieldVisible,
      //             child: ProductInfoFormfield(
      //                 scanBarcode: scanBarcode,
      //                 selectDate: _selectDate,
      //                 selectedDate: selectedDate ?? DateTime.now())),
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.blue,
                selectedItemColor: Colors.white,
                // unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    index == 2 ? null : _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings_outlined), label: 'Setting'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.abc),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.show_chart), label: 'Historique'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: 'Historique')
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: _isTextFieldVisible ? Colors.blue : Colors.blueGrey,
          child: const Icon(Icons.barcode_reader),
          onPressed: () => setState(() {
            scanBarcode();
            //_showInfoPopup();
            _isTextFieldVisible = false;
            //_currentIndex = 1;
          }),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
