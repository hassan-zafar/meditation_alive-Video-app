import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String? productId;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  final bool? isIndividual;
  final String? gameTime;
  final bool? isFavorite;
  final bool? isPopular;
  final String? pallets;
  final int? groupMembers;
  final String? productCategoryName;
  Product({
    this.productId,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.groupMembers,
    this.isIndividual,
    this.gameTime,
    this.isFavorite,
    this.isPopular,
    this.pallets,
    this.productCategoryName,
  });
  factory Product.fromDocument(doc) {
    return Product(
        productId: doc.data()["productId"],
        title: doc.data()["productTitle"],
        description: doc.data()["productDescription"],
        price: double.parse(doc.data()["price"]),
        imageUrl: doc.data()["productImage"],
        groupMembers: doc.data()["groupMembers"],
        isIndividual: doc.data()["isIndividual"],
        gameTime: doc.data()["gameTime"],
        isFavorite: doc.data()["isFavorite"],
        pallets: doc.data()["pallets"],
        productCategoryName: doc.data()["productCategory"],
        isPopular: true);
  }
}
