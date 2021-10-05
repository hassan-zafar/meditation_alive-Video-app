import 'package:volt_arena/consts/colors.dart';
import 'package:volt_arena/models/favs_attr.dart';
import 'package:volt_arena/provider/favs_provider.dart';
import 'package:volt_arena/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistFull extends StatefulWidget {
  final String productId;

  const WishlistFull({required this.productId});
  @override
  _WishlistFullState createState() => _WishlistFullState();
}

class _WishlistFullState extends State<WishlistFull> {
  @override
  Widget build(BuildContext context) {
    final favsAttr = Provider.of<FavsAttr>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      child: Image.network(
                        favsAttr.imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favsAttr.title!,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${favsAttr.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productId),
      ],
    );
  }

  Widget positionedRemove(String productId) {
    final favsProvider = Provider.of<FavsProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(0.0),
            color: ColorsConsts.favColor,
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () => {
                  globalMethods.showDialogg(
                      'Remove wish!',
                      'This product will be removed from your wishlist!',
                      () => favsProvider.removeItem(productId),
                      context),
                }),
      ),
    );
  }
}
