import 'package:flutter/material.dart';

final List<String>images = [
  'assets/images/img1.jpg',
  'assets/images/img2.jpg',
  'assets/images/img3.jpg',
  'assets/images/img4.jpg',
  'assets/images/img5.jpg',
  'assets/images/img6.jpg',
  'assets/images/img7.jpg',
];

final List<String> name = ['Levise', 'Nike', 'Polo', 'Addidas'];

List<Widget> genrateImageTiles() {
  return images
      .map((e) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                image: DecorationImage(image: AssetImage(e),fit: BoxFit.cover)),
          ))
      .toList();
}
