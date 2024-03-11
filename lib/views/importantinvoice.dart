// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
//
// // Define the Product class
// class Product {
//   String sku;
//   String productName;
//   double price;
//   int quantity;
//
//   Product(this.sku, this.productName, this.price, this.quantity);
//
//   double get total => price * quantity;
// }
//
// // UI for collecting product input
// class ProductInputPage extends StatefulWidget {
//   @override
//   _ProductInputPageState createState() => _ProductInputPageState();
// }
//
// class _ProductInputPageState extends State<ProductInputPage> {
//   List<Product> products = [];
//
//   TextEditingController skuController = TextEditingController();
//   TextEditingController productNameController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Product Details'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           TextField(
//             controller: skuController,
//             decoration: InputDecoration(labelText: 'SKU'),
//           ),
//           TextField(
//             controller: productNameController,
//             decoration: InputDecoration(labelText: 'Product Name'),
//           ),
//           TextField(
//             controller: priceController,
//             decoration: InputDecoration(labelText: 'Price'),
//             keyboardType: TextInputType.number,
//           ),
//           TextField(
//             controller: quantityController,
//             decoration: InputDecoration(labelText: 'Quantity'),
//             keyboardType: TextInputType.number,
//           ),
//           RaisedButton(
//             onPressed: () {
//               setState(() {
//                 // Create a new Product instance with user input
//                 Product product = Product(
//                   skuController.text,
//                   productNameController.text,
//                   double.parse(priceController.text),
//                   int.parse(quantityController.text),
//                 );
//                 // Add the product to the list of products
//                 products.add(product);
//                 // Clear the text fields for the next input
//                 skuController.clear();
//                 productNameController.clear();
//                 priceController.clear();
//                 quantityController.clear();
//               });
//             },
//             child: Text('Add Product'),
//           ),
//           RaisedButton(
//             onPressed: () async {
//               // Call the generateInvoice function with the collected products
//               Uint8List pdfBytes = await generateInvoicePdf(products);
//               // Display the generated PDF
//               await Printing.layoutPdf(
//                   onLayout: (PdfPageFormat format) async => pdfBytes);
//             },
//             child: Text('Generate Invoice'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Function to generate the invoice PDF with the collected products
// Future<Uint8List> generateInvoicePdf(List<Product> products) async {
//   final pdf = pw.Document();
//
//   // Add invoice content
//   pdf.addPage(
//     pw.MultiPage(
//       build: (pw.Context context) => [
//         // Your invoice content here
//         pw.Table.fromTextArray(
//           data: [
//             ['SKU', 'Product Name', 'Price', 'Quantity', 'Total'],
//             ...products.map((product) => [
//               product.sku,
//               product.productName,
//               '${product.price}',
//               '${product.quantity}',
//               '${product.total}',
//             ])
//           ],
//         ),
//       ],
//     ),
//   );
//
//   // Save the PDF to a temporary file
//   return pdf.save();
// }
//
// void main() {
//   runApp(MaterialApp(home: ProductInputPage()));
// }
