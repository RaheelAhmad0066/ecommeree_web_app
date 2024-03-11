import 'dart:convert';
import 'dart:typed_data';

class ProductModal {
  Uint8List imageData;
  String name;
  String price;
  String size;
  String brand;
  String description;

  ProductModal({
    required this.imageData,
    required this.name,
    required this.price,
    required this.size,
    required this.brand,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageData': base64Encode(imageData),
      'name': name,
      'size': size,
      'price': price,
      'brand': brand,
      'description': description,
    };
  }

  factory ProductModal.fromMap(Map<String, dynamic> map) {
    return ProductModal(
      imageData: base64Decode(map['imageData']),
      name: map['name'],
      price: map['price'],
      size: map['size'],
      brand: map['brand'],
      description: map['description'],
    );
  }
}
