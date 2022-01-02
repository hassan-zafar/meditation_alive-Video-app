import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/my_icons.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/provider/favs_provider.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/services/global_method.dart';
import 'package:provider/provider.dart';
import 'downloaded_empty.dart';
import 'downloaded_full.dart';

class DownloadScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  List<Product>? products;
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    final Products productsProvider = Provider.of<Products>(context);
    // favsProvider.getFavsItems.forEach((key, value) {
    //   products!.add(productsProvider.findById(value.id!));
    // });
    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(body: DownloadedEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Favourites (${favsProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear favourites!',
                        'Your favourites will be cleared!',
                        () => favsProvider.clearFavs(),
                        context);
                    // cartProvider.clearCart();
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: favsProvider.getFavsItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                    value: favsProvider.getFavsItems.values.toList()[index],
                    child: DownloadedFull(
                      products: products!,
                      productId: favsProvider.getFavsItems.keys.toList()[index],
                    ));
              },
            ),
          );
  }
}
