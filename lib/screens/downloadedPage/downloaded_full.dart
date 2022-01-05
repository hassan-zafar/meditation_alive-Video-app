// import 'package:flutter/material.dart';
// import 'package:meditation_alive/consts/collections.dart';
// import 'package:meditation_alive/consts/colors.dart';
// import 'package:meditation_alive/models/favs_attr.dart';
// import 'package:meditation_alive/models/product.dart';
// import 'package:meditation_alive/provider/favs_provider.dart';
// import 'package:meditation_alive/provider/products.dart';
// import 'package:meditation_alive/screens/videoPage.dart';
// import 'package:meditation_alive/services/global_method.dart';
// import 'package:provider/provider.dart';

// class DownloadedFull extends StatefulWidget {
//   final String productId;
//   final List<Product> products;
//   const DownloadedFull({required this.productId,required this.products});
//   @override
//   _DownloadedFullState createState() => _DownloadedFullState();
// }

// class _DownloadedFullState extends State<DownloadedFull> {
//   @override
//   Widget build(BuildContext context) {
//     final favsAttr = Provider.of<FavsAttr>(context);
//     final Products productsProvider = Provider.of<Products>(context);

//     final favsProvider = Provider.of<FavsProvider>(context);
//     return Stack(
//       children: <Widget>[
//         Container(
//           width: double.infinity,
//           margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
//           child: Material(
//             color: Theme.of(context).backgroundColor,
//             borderRadius: BorderRadius.circular(5.0),
//             elevation: 3.0,
//             child: InkWell(
//               onTap: () {
//                 Product product = productsProvider.findById(widget.productId); DateTime subEndTime =
//                         DateTime.parse(currentUser!.subscriptionEndTIme!);
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => VideoPage(
//                     product: product,notPaid: subEndTime
//                                         .isBefore(DateTime.now()),
//                     allProducts: widget.products,
//                   ),
//                 ));
//               },
//               child: Container(
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       height: 100,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(15),
//                               topLeft: Radius.circular(15))),
//                       child: Image.network(
//                         favsAttr.imageUrl!,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10.0,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             favsAttr.title!,
//                             style: TextStyle(
//                                 fontSize: 16.0, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Text(
//                             "${favsAttr.category}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         positionedRemove(widget.productId),
//       ],
//     );
//   }

//   Widget positionedRemove(String productId) {
//     final favsProvider = Provider.of<FavsProvider>(context);
//     GlobalMethods globalMethods = GlobalMethods();
//     return Positioned(
//       top: 20,
//       right: 15,
//       child: Container(
//         height: 30,
//         width: 30,
//         child: MaterialButton(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0)),
//             padding: EdgeInsets.all(0.0),
//             color: ColorsConsts.favColor,
//             child: Icon(
//               Icons.clear,
//               color: Colors.white,
//             ),
//             onPressed: () => {
//                   globalMethods.showDialogg(
//                       'Remove Favourite!',
//                       'This product will be removed from your favourites!',
//                       () => favsProvider.removeItem(productId),
//                       context),
//                 }),
//       ),
//     );
//   }
// }
