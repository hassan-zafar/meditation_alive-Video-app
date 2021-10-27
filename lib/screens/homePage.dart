import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/provider/favs_provider.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/screens/search.dart';
import 'package:meditation_alive/screens/user_info.dart';
import 'package:meditation_alive/screens/videoPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // EventshomeWidget({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? choiceChipsValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
// list of string options
  List<String> tags = [];

  List<String> options = [
    'Popular',
    'BEGINNERS',
    "ALL",
  ];
  List<Product> dailyVideos = [];
  List<Product> movementVideos = [];
  List<Product> seatedVideos = [];
  List<Product> thinkingVideos = [];
  List<Product> educationVideos = [];
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _getProductsOnRefresh();
  }

  Future<void> _getProductsOnRefresh() async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
    // final Products _productsProvider = Provider.of<Products>(context);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Products productsProvider = Provider.of<Products>(context);

    final favsProvider = Provider.of<FavsProvider>(context);

    dailyVideos = [];
    movementVideos = [];
    seatedVideos = [];
    thinkingVideos = [];
    educationVideos = [];
    productsProvider.products.forEach((element) {
      if (element.productCategoryName == "Daily" &&
          !dailyVideos.contains(element)) {
        dailyVideos.add(element);
      }
      if (element.productCategoryName == "Seated" &&
          !seatedVideos.contains(element)) {
        seatedVideos.add(element);
      }
      if (element.productCategoryName == "Thinking" &&
          !thinkingVideos.contains(element)) {
        thinkingVideos.add(element);
      }
      if (element.productCategoryName == "Education" &&
          !educationVideos.contains(element)) {
        educationVideos.add(element);
      }
      if (element.productCategoryName == "Movement" &&
          !movementVideos.contains(element)) {
        movementVideos.add(element);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E2429),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserInfoScreen(),
          )),
          child: CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.person,
            ),
          ),
        ),
        actions: [
          InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Search(),
                  )),
              child: CircleAvatar(radius: 30, child: Icon(Icons.search)))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getProductsOnRefresh,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: productsProvider.products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final prodAttr = productsProvider.findById(
                            productsProvider.products[index].productId!);

                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VideoPage(
                                product: productsProvider.products[index],
                              ),
                            )),
                            child: Container(
                              width: 250,
                              height: 170,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      productsProvider
                                          .products[index].imageUrl!),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x64000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 4, 8, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          color: Color(0x9839D2C0),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6, 2, 6, 2),
                                            child: Text(
                                              'UnLock',
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            favsProvider.addAndRemoveFromFav(
                                              productsProvider
                                                  .products[index].productId!,
                                              prodAttr.videoUrl!,
                                              prodAttr.title!,
                                              prodAttr.imageUrl!,
                                              prodAttr.productCategoryName!,
                                            );
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFF1E2429),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 8, 8, 8),
                                              child: Icon(
                                                favsProvider.getFavsItems
                                                        .containsKey(
                                                            productsProvider
                                                                .products[index]
                                                                .productId)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                productsProvider
                                                    .products[index].title!,
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              // Text(
                                              //   'Seated Medication',
                                              //   style: TextStyle(
                                              //     fontFamily: 'Lexend Deca',
                                              //     color: Colors.white,
                                              //     fontSize: 12,
                                              //     fontWeight: FontWeight.normal,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                        // Column(
                                        //   mainAxisSize: MainAxisSize.max,
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       '7 min',
                                        //       style: TextStyle(
                                        //         fontFamily: 'Poppins',
                                        //         color: Color(0xFFD6D6D6),
                                        //         fontSize: 12,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       'Ambient',
                                        //       style: TextStyle(
                                        //         fontFamily: 'Poppins',
                                        //         color: Color(0xFFD6D6D6),
                                        //         fontSize: 12,
                                        //       ),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: CategoryHeading(
                    categoryName: 'Daily',
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (dailyVideos.length > 0) {
                        return CategoryItemsViewer(
                          path: dailyVideos[index].videoUrl,
                          product: dailyVideos[index],
                          imageUrl: dailyVideos[index].imageUrl,
                          postId: dailyVideos[index].productId,
                          category: dailyVideos[index].productCategoryName,
                          videoLength: dailyVideos[index].videoLength,
                          videoText: dailyVideos[index].title,
                        );
                      } else {
                        return Text(
                          "Currently No Video Uploaded",
                          style: titleTextStyle(),
                        );
                      }
                    },
                    itemCount: dailyVideos.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: CategoryHeading(
                    categoryName: 'Movement',
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (movementVideos.length > 0) {
                        return CategoryItemsViewer(
                          path: movementVideos[index].videoUrl,
                          product: movementVideos[index],
                          imageUrl: movementVideos[index].imageUrl,
                          postId: movementVideos[index].productId,
                          category: movementVideos[index].productCategoryName,
                          videoLength: movementVideos[index].videoLength,
                          videoText: movementVideos[index].title,
                        );
                      } else {
                        return Text(
                          "Currently No Video Uploaded",
                          style: titleTextStyle(),
                        );
                      }
                    },
                    itemCount: movementVideos.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: CategoryHeading(
                    categoryName: 'Seated',
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (seatedVideos.length > 0) {
                        return CategoryItemsViewer(
                          path: seatedVideos[index].videoUrl,
                          product: seatedVideos[index],
                          imageUrl: seatedVideos[index].imageUrl,
                          postId: seatedVideos[index].productId,
                          category: seatedVideos[index].productCategoryName,
                          videoLength: seatedVideos[index].videoLength,
                          videoText: seatedVideos[index].title,
                        );
                      } else {
                        return Text(
                          "Currently No Video Uploaded",
                          style: titleTextStyle(),
                        );
                      }
                    },
                    itemCount: seatedVideos.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: CategoryHeading(
                    categoryName: 'Thinking',
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (thinkingVideos.length > 0) {
                        return CategoryItemsViewer(
                          path: thinkingVideos[index].videoUrl,
                          product: thinkingVideos[index],
                          imageUrl: thinkingVideos[index].imageUrl,
                          postId: thinkingVideos[index].productId,
                          category: thinkingVideos[index].productCategoryName,
                          videoLength: thinkingVideos[index].videoLength,
                          videoText: thinkingVideos[index].title,
                        );
                      } else {
                        return Text(
                          "Currently No Video Uploaded",
                          style: titleTextStyle(),
                        );
                      }
                    },
                    itemCount: thinkingVideos.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: CategoryHeading(
                    categoryName: 'Education',
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (educationVideos.length > 0) {
                        return CategoryItemsViewer(
                          path: educationVideos[index].videoUrl,
                          product: educationVideos[index],
                          imageUrl: educationVideos[index].imageUrl,
                          postId: educationVideos[index].productId,
                          category: educationVideos[index].productCategoryName,
                          videoLength: educationVideos[index].videoLength,
                          videoText: educationVideos[index].title,
                        );
                      } else {
                        return Text(
                          "Currently No Video Uploaded",
                          style: titleTextStyle(),
                        );
                      }
                    },
                    itemCount: educationVideos.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryHeading extends StatelessWidget {
  final String? categoryName;
  const CategoryHeading({
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryName!,
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(Icons.chevron_right_rounded),
      ],
    );
  }
}

class CategoryItemsViewer extends StatelessWidget {
  final String? path;
  final String? postId;
  final String? videoLength;
  final String? videoText;
  final String? category;
  final String? imageUrl;
  final Product? product;

  const CategoryItemsViewer(
      {this.path,
      this.postId,
      this.videoLength,
      this.imageUrl,
      this.category,
      required this.product,
      this.videoText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VideoPage(
              product: product,
            ),
          ));
        },
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 250,
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(imageUrl!),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x64000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Card(
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         color: Color(0xFF1E2429),
                  //         elevation: 2,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30),
                  //         ),
                  //         child: Padding(
                  //           padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  //           child: Icon(
                  //             Icons.favorite_border,
                  //             color: Colors.white,
                  //             size: 24,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Column(
                    // mainAxisSize: MainAxisSize.max,

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          videoText!,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: Text(
                              videoLength!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFF5F5F5),
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          // Text(
                          //   'Guitar',
                          //   style: TextStyle(
                          //     fontFamily: 'Poppins',
                          //     color: Color(0xFFF5F5F5),
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w100,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  Content({
    // Key key,
    required this.title,
    required this.child,
  });

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content>
    with AutomaticKeepAliveClientMixin<Content> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            color: Colors.blueGrey[50],
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}

// void _about(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) => Dialog(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ListTile(
//             title: Text(
//               'chips_choice',
//               style: TextStyle(color: Colors.black87),
//             ),
//             subtitle: const Text('by davigmacode'),
//             trailing: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           Flexible(
//             fit: FlexFit.loose,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     'Easy way to provide a single or multiple choice chips.',
//                     style: TextStyle(color: Colors.black87),
//                   ),
//                   Container(height: 15),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
