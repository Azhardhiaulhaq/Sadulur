import 'dart:core';

class StoreProduct {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final int seenNumber;

  StoreProduct(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.seenNumber = 0});
}
