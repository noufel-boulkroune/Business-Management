// ignore_for_file: unused_field, use_full_hex_values_for_flutter_colors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:business_management/constante/spacing.dart';
import 'package:business_management/view/screen/entree_sorties/widget/custom_text_form_field.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class EntreeScreen extends StatefulWidget {
  const EntreeScreen({super.key});

  @override
  State<EntreeScreen> createState() => _EntreeScreenState();
}

class _EntreeScreenState extends State<EntreeScreen> {
  String _scanBarcode = '';
  bool _isTextFieldVisible = false;
  DateTime? selectedDate;
  void _incrementCounter() {
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
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      if (!mounted) return;

      setState(() {
        _scanBarcode = barcodeScanRes;
      });
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: _isTextFieldVisible,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Card(
                    color: const Color(0xffcf4f4f7),
                    shadowColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.MARGIN_SIZE_LARG,
                          vertical: Spacing.MARGIN_SIZE_LARG),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              "Entre the products information",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const CustomTextFormField(
                              productHint: 'Price',
                              productLabel: 'Enter the price',
                              fieldIcon: EvaIcons.creditCardOutline,
                            ),
                            const CustomTextFormField(
                                productHint: 'Quantity',
                                productLabel: 'Enter the quantity',
                                fieldIcon: EvaIcons.plusCircleOutline),
                            const CustomTextFormField(
                              productHint: 'Lot',
                              productLabel: 'Enter the lot',
                              fieldIcon: EvaIcons.gridOutline,
                            ),
                            const CustomTextFormField(
                              productHint: 'Zone',
                              productLabel: 'Enter the zone',
                              fieldIcon: EvaIcons.mapOutline,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      scanBarcode();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade300),
                                    child: const Icon(
                                      Icons.barcode_reader,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //Location
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade300),
                                    child: const Icon(
                                      EvaIcons.pinOutline,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _selectDate(context);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    EvaIcons.calendarOutline,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  selectedDate == null
                                      ? 'No date selected'
                                      : 'Selected date: ${DateFormat('dd/MM/yyyy').format(selectedDate!).toString()}',
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
