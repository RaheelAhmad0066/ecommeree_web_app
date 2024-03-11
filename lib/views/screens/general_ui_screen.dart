import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce/model/add_product_modal.dart';
import 'package:ecommerce/views/widgets/custom_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants/dimens.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/theme/theme_extensions/app_color_scheme.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/dropdown_widget.dart';

class GeneralUiScreen extends StatefulWidget {
  GeneralUiScreen({Key? key}) : super(key: key);

  @override
  State<GeneralUiScreen> createState() => _GeneralUiScreenState();
}

class _GeneralUiScreenState extends State<GeneralUiScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedsize = 'Medium';
  String selectedValue = 'Levi\'s';
  List<ProductModal> products = [];
  final List<String> items = [
    'Levi\'s',
    'Tommy Hilfiger',
    'Torrid',
    'Old Navy',
    'H&M',
    'Nike',
    'Adidas',
  ];
  final List<String> sizes = [
    'Medium',
    'Large',
    'Extra Large',
    'Old Navy',
    'XXL',
    'Regular',
    'Plus Size',
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  _loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      products = (prefs.getStringList('products') ?? []).map((item) {
        Map<String, dynamic> productMap = jsonDecode(item);
        return ProductModal.fromMap(productMap);
      }).toList();
    });
  }

  _saveProduct(ProductModal product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productList = prefs.getStringList('products') ?? [];
    productList.add(jsonEncode(product.toMap()));
    await prefs.setStringList('products', productList);
  }

  Uint8List? _imageData;

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        final bytes = result.files.first.bytes;
        if (bytes != null) {
          setState(() {
            _imageData = bytes;
          });
        }
      }
    } catch (e) {
      print('Error while picking the image: $e');
    }
  }

  int maxdescriptionlength = 40;

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    Size size = MediaQuery.of(context).size;
    return PortalMasterLayout(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Items',
                    style: themeData.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  Center(
                    child: Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Container(
                          height: constraints.maxHeight * 0.3,
                          width: constraints.maxWidth * 0.5,
                          decoration: BoxDecoration(
                              image: _imageData != null
                                  ? DecorationImage(
                                      image: MemoryImage(_imageData!),
                                      fit: BoxFit.cover)
                                  : null,
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 14,
                                  child: Icon(Iconsax.add),
                                ),
                                SizedBox(
                                  width: kDefaultPadding,
                                ),
                                Text(
                                  'Add product image',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        controller: nameController,
                        title: 'Add product name',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      CustomField(
                        controller: priceController,
                        title: 'Add Product price',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Brand',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                            Dropdownbutton(
                              items: items,
                              selectedvalue: selectedValue,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.01,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Size',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                            Dropdownbutton(
                              items: sizes,
                              selectedvalue: selectedsize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      CustomField(
                        minLine: 4,
                        maxline: 10,
                        controller: descriptionController,
                        title: 'Add Product description',
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Center(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.05,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as per your preference
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors
                                .green), // Change the color to your desired one
                          ),
                          onPressed: () {
                            final product = ProductModal(
                                imageData: _imageData ?? Uint8List(0),
                                name: nameController.text,
                                price: priceController.text,
                                size: selectedsize.toString(),
                                brand: selectedValue.toString(),
                                description: descriptionController.text);
                            _saveProduct(product);

                            nameController.clear();
                            priceController.clear();
                            selectedValue = '';
                            selectedsize = '';
                            descriptionController.clear();
                          },
                          child: const Text(
                            'Update Items',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
