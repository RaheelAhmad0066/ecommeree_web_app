import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:iconsax/iconsax.dart';
import '../../constants/dimens.dart';
import '../../model/invoice.dart';
import '../widgets/custom_field_widget.dart';

List<Product> mainproduct = [];

class New_Items extends StatefulWidget {
  New_Items({Key? key}) : super(key: key);

  @override
  State<New_Items> createState() => _New_ItemsState();
}

class _New_ItemsState extends State<New_Items> {

  final _dataTableHorizontalScrollController = ScrollController();

  TextEditingController skuController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PortalMasterLayout(
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
      final double dataTableWidth = max(kScreenWidthMd, constraints.maxWidth);
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Add Items',
              style: themeData.textTheme.headlineMedium,
            ),
            const Text(
              'add items to your invoice',
            ),
            SizedBox(height: kDefaultPadding),
            Column(
              children: [
                const SizedBox(height: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SKU',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    CustomField(
                      controller: skuController,
                      title: 'add your sku',
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Name',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    CustomField(
                      controller: productNameController,
                      title: 'add your product name',
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    CustomField(
                      controller: priceController,
                      title: 'add your product price',
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantyt',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    CustomField(
                      controller: quantityController,
                      title: 'add your product quantyt',
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
                if(mainproduct.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double dataTableWidth =
                          max(kScreenWidthMd, constraints.maxWidth);
                      return Scrollbar(
                        controller: _dataTableHorizontalScrollController,
                        thumbVisibility: false,
                        trackVisibility: false,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _dataTableHorizontalScrollController,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)),
                            width: dataTableWidth,
                            child: DataTable(
                              showCheckboxColumn: true,
                              showBottomBorder: false,
                              columns: const [
                                DataColumn(label: Text('No.'), numeric: false),
                                DataColumn(label: Text('Product Name')),
                                DataColumn(label: Text('Quantyt')),
                                DataColumn(label: Text('Price'), numeric: true),
                              ],
                              rows: mainproduct.map((product) {
                                return DataRow(cells: [
                                  DataCell(Text(product.sku)),
                                  DataCell(Text(product.productName)),
                                  DataCell(Text(product.quantity.toString())),
                                  DataCell(Text(product.price.toString())),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
          
                Center(
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.05,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as per your preference
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                              .green), // Change the color to your desired one
                        ),
                        onPressed: () {
                          setState(() {
                            Product product = Product(
                              skuController.text,
                              productNameController.text,
                              double.parse(priceController.text),
                              int.parse(quantityController.text),
                            );
                            mainproduct.add(product);
                            skuController.clear();
                            productNameController.clear();
                            priceController.clear();
                            quantityController.clear();
                          });
                        },
                        child: const Text(
                          'Update Items',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ]),
        ),
      );
    }));
  }
}
