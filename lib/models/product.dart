import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String? productId;
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? imageUrl;
  final bool? isIndividual;
  final bool? isFavorite;
  final bool? isPopular;
  final String? productCategoryName;
  Product({
    this.productId,
    this.title,
    this.description,
    this.videoUrl,
    this.imageUrl,
    this.isIndividual,
    this.isFavorite,
    this.isPopular,
    this.productCategoryName,
  });
  factory Product.fromDocument(doc) {
    return Product(
        productId: doc.data()["productId"],
        title: doc.data()["productTitle"],
        description: doc.data()["productDescription"],
        videoUrl: doc.data()["videoUrl"],
        imageUrl: doc.data()["productImage"],
        isIndividual: doc.data()["isIndividual"],
        isFavorite: doc.data()["isFavorite"],
        productCategoryName: doc.data()["productCategory"],
        isPopular: true);
  }

  get id => null;
}
