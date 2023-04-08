import 'dart:io';
import 'package:business_management/controller/add_products_controller.dart';
import 'package:business_management/view/screen/entree_sorties/widget/custom_text_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProductInfoFormfield extends StatefulWidget {
  Function scanBarcode, selectDate;
  DateTime selectedDate;
  String barcode;

  ProductInfoFormfield(
      {super.key,
      required this.scanBarcode,
      required this.selectDate,
      required this.selectedDate,
      required this.barcode});

  @override
  State<ProductInfoFormfield> createState() => _ProductInfoFormfieldState();
}

class _ProductInfoFormfieldState extends State<ProductInfoFormfield> {
  String selectedCategory = "";
  @override
  void initState() {
    super.initState();
    // selectedCategory = category.first;
  }

  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
    return imageTemporary;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductsController>(
      init: AddProductsController(),
      builder: (controller) => SizedBox(
        width: MediaQuery.of(context).size.width,
        //child: Container(
        // padding: const EdgeInsets.symmetric(
        //     horizontal: Spacing.MARGIN_SIZE_LARG,
        //     vertical: Spacing.MARGIN_SIZE_LARG),
        child: Center(
          child: SingleChildScrollView(
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    DottedBorder(
                        color: Colors.lightBlue,
                        dashPattern: const [8, 4],
                        radius: const Radius.circular(5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.width * .3,
                          child: Center(
                            child: _image == null
                                ? IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.lightBlue,
                                    ))
                                : Image.file(
                                    _image!,
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height:
                                        MediaQuery.of(context).size.width * .3,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.width * .3,
                      child: Center(
                        child: Text(widget.barcode),
                      ),
                    )
                  ],
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  // value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: controller.category
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  // value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: controller.convenience_store
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomTextFormField(
                  productHint: 'Product',
                  productLabel: 'Enter the product name',
                  fieldIcon: EvaIcons.creditCardOutline,
                ),
                const CustomTextFormField(
                    productHint: 'charge',
                    productLabel: 'charge',
                    fieldIcon: EvaIcons.plusCircleOutline),
                const CustomTextFormField(
                  productHint: 'fournisseurs',
                  productLabel: 'fournisseurs',
                  fieldIcon: EvaIcons.gridOutline,
                ),
                const CustomTextFormField(
                  productHint: 'stock',
                  productLabel: 'stock',
                  fieldIcon: EvaIcons.mapOutline,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () {
                //           widget.scanBarcode();
                //         },
                //         style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.blue.shade300),
                //         child: const Icon(
                //           Icons.barcode_reader,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 14,
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () {
                //           //Location
                //         },
                //         style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.blue.shade300),
                //         child: const Icon(
                //           EvaIcons.pinOutline,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.selectDate(context);
                      },
                      icon: const Icon(
                        EvaIcons.calendarOutline,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Selected date: ${DateFormat('dd/MM/yyyy').format(widget.selectedDate).toString()}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
