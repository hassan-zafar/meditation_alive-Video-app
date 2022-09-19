import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/collections.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/database/database.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/models/users.dart';
import 'package:meditation_alive/provider/favs_provider.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/screens/adminScreens/uploadVideo.dart';
import 'package:meditation_alive/screens/payment_screen.dart';
import 'package:meditation_alive/screens/search.dart';
import 'package:meditation_alive/screens/user_info.dart';
import 'package:meditation_alive/screens/videoPage.dart';
import 'package:meditation_alive/widgets/custom_toast%20copy.dart';
import 'package:meditation_alive/widgets/loadingWidget.dart';
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
  List<Product> educationalVideos = [];
  List<Product> taskVideos = [];
  List<Product> relaxingVideos = [];
  // DateTime? subEndTime;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getProductsOnRefresh();
    // getCurrrentUser();
  }

  getCurrrentUser() async {
    setState(() {
      isLoading = true;
    });
    AppUserModel currentUserTemp = await DatabaseMethods()
        .fetchUserInfoFromFirebase(uid: currentUser!.id!);
    setState(() {
      isLoading = false;
      currentUser = currentUserTemp;
    });
    print(currentUser);
  }

  Future<void> getProductsOnRefresh() async {
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
    educationalVideos = [];
    taskVideos = [];
    relaxingVideos = [];

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
      if (element.productCategoryName == "Educational" &&
          !educationalVideos.contains(element)) {
        educationalVideos.add(element);
      }
      if (element.productCategoryName == "Movement" &&
          !movementVideos.contains(element)) {
        movementVideos.add(element);
      }
      if (element.productCategoryName == "Task" &&
          !taskVideos.contains(element)) {
        taskVideos.add(element);
      }
      if (element.productCategoryName == "Relaxing" &&
          !relaxingVideos.contains(element)) {
        relaxingVideos.add(element);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Color(0xFF1E2429),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserInfoScreen(),
          )),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: Icon(Icons.person, size: 20, color: Colors.white),
          ),
        ),
        actions: [
          InkWell(
            onTap: () =>
                // FirebaseApi.downloadFile(fileName: 'asd'),
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Search(),
            )),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getProductsOnRefresh,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
                                child: InkWell(
                                  onLongPress: () {
                                    currentUser!.isAdmin!
                                        ? showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    children: <Widget>[
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                UploadProductForm(
                                                                    isEditable:
                                                                        true,
                                                                    details: productsProvider
                                                                            .products[
                                                                        index]),
                                                          ));
                                                        },
                                                        child: Text(
                                                          'Edit Video',
                                                        ),
                                                      ),
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                          setState(() {
                                                            isLoading = true;
                                                          });

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'products')
                                                              .doc(prodAttr
                                                                  .productId)
                                                              .delete()
                                                              .then((value) =>
                                                                  getProductsOnRefresh);

                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Delete Video',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                      SimpleDialogOption(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text('Cancel'),
                                                      )
                                                    ],
                                                  );
                                                })
                                            .then(
                                                (value) => getProductsOnRefresh)
                                        : null;
                                  },
                                  onTap: () {
                                    DateTime subEndTime = DateTime.parse(
                                        currentUser!.subscriptionEndTIme!);
                                    if (currentUser!.email ==
                                        'guest@guest.com') {
                                      CustomToast.errorToast(
                                          message:
                                              'LogIn with google or email to continue');
                                    } else if (subEndTime
                                        .isBefore(DateTime.now())) {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => PaymentScreen(
                                                product: productsProvider
                                                    .products[index],
                                                allProducts:
                                                    productsProvider.products,
                                              )
                                          // VideoPage(
                                          // product: productsProvider.products[index],
                                          // allProducts: productsProvider.products,
                                          // ),
                                          ));
                                    } else {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VideoPage(
                                          product:
                                              productsProvider.products[index],
                                          notPaid: subEndTime
                                              .isBefore(DateTime.now()),
                                          allProducts:
                                              productsProvider.products,
                                        ),
                                      ));
                                    }
                                  },
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(6, 2, 6, 2),
                                                  child: DateTime.parse(currentUser!
                                                              .subscriptionEndTIme!)
                                                          .isBefore(
                                                              DateTime.now())
                                                      ? Text(
                                                          'UnLock',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 0,
                                                        ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  favsProvider
                                                      .addAndRemoveFromFav(
                                                    productsProvider
                                                        .products[index]
                                                        .productId!,
                                                    prodAttr.videoUrl!,
                                                    prodAttr.title!,
                                                    prodAttr.imageUrl!,
                                                    prodAttr
                                                        .productCategoryName!,
                                                  );
                                                },
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: Color(0xFF1E2429),
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 8, 8, 8),
                                                    child: Icon(
                                                      favsProvider.getFavsItems
                                                              .containsKey(
                                                                  productsProvider
                                                                      .products[
                                                                          index]
                                                                      .productId)
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 0, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      productsProvider
                                                          .products[index]
                                                          .title!,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                allProducts: dailyVideos,
                                product: dailyVideos[index],
                                imageUrl: dailyVideos[index].imageUrl,
                                postId: dailyVideos[index].productId,
                                category:
                                    dailyVideos[index].productCategoryName,
                                videoLength: dailyVideos[index].videoLength,
                                videoText: dailyVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
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
                                allProducts: movementVideos,
                                product: movementVideos[index],
                                imageUrl: movementVideos[index].imageUrl,
                                postId: movementVideos[index].productId,
                                category:
                                    movementVideos[index].productCategoryName,
                                videoLength: movementVideos[index].videoLength,
                                videoText: movementVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
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
                                allProducts: seatedVideos,
                                product: seatedVideos[index],
                                imageUrl: seatedVideos[index].imageUrl,
                                postId: seatedVideos[index].productId,
                                category:
                                    seatedVideos[index].productCategoryName,
                                videoLength: seatedVideos[index].videoLength,
                                videoText: seatedVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
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
                                allProducts: thinkingVideos,
                                product: thinkingVideos[index],
                                imageUrl: thinkingVideos[index].imageUrl,
                                postId: thinkingVideos[index].productId,
                                category:
                                    thinkingVideos[index].productCategoryName,
                                videoLength: thinkingVideos[index].videoLength,
                                videoText: thinkingVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
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
                          categoryName: 'Educational',
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (educationalVideos.length > 0) {
                              return CategoryItemsViewer(
                                path: educationalVideos[index].videoUrl,
                                allProducts: educationalVideos,
                                product: educationalVideos[index],
                                imageUrl: educationalVideos[index].imageUrl,
                                postId: educationalVideos[index].productId,
                                category: educationalVideos[index]
                                    .productCategoryName,
                                videoLength:
                                    educationalVideos[index].videoLength,
                                videoText: educationalVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
                              );
                            }
                          },
                          itemCount: educationalVideos.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: CategoryHeading(
                          categoryName: 'Task',
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (taskVideos.length > 0) {
                              return CategoryItemsViewer(
                                path: taskVideos[index].videoUrl,
                                allProducts: taskVideos,
                                product: taskVideos[index],
                                imageUrl: taskVideos[index].imageUrl,
                                postId: taskVideos[index].productId,
                                category: taskVideos[index].productCategoryName,
                                videoLength: taskVideos[index].videoLength,
                                videoText: taskVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
                              );
                            }
                          },
                          itemCount: taskVideos.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: CategoryHeading(
                          categoryName: 'Relaxing',
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (relaxingVideos.length > 0) {
                              return CategoryItemsViewer(
                                path: relaxingVideos[index].videoUrl,
                                allProducts: relaxingVideos,
                                product: relaxingVideos[index],
                                imageUrl: relaxingVideos[index].imageUrl,
                                postId: relaxingVideos[index].productId,
                                category:
                                    relaxingVideos[index].productCategoryName,
                                videoLength: relaxingVideos[index].videoLength,
                                videoText: relaxingVideos[index].title,
                              );
                            } else {
                              return Text(
                                "Currently No Video Uploaded",
                                style: titleTextStyle(
                                  context: context,
                                ),
                              );
                            }
                          },
                          itemCount: relaxingVideos.length,
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
  final List<Product>? allProducts;
  const CategoryItemsViewer(
      {this.path,
      this.postId,
      this.videoLength,
      this.imageUrl,
      this.category,
      required this.allProducts,
      required this.product,
      this.videoText});

  @override
  Widget build(BuildContext context) {
    DateTime subEndTime = DateTime.parse(currentUser!.subscriptionEndTIme!);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      child: InkWell(
        onTap: () async {
          if (currentUser!.subscriptionEndTIme == null ||
              currentUser!.subscriptionEndTIme!.isEmpty) {
            LoadingIndicator();
            await userRef.doc(currentUser!.id).update({
              'subscriptionEndTIme': DateTime.now().toIso8601String(),
            });
            DocumentSnapshot asd = await userRef.doc(currentUser!.id).get();
            currentUser = AppUserModel.fromDocument(asd);
          }
          if (currentUser!.email == 'guest@guest.com') {
            CustomToast.errorToast(
                message: 'LogIn with google or email to continue');
          }
          //  else if (subEndTime.isBefore(DateTime.now())) {
          //   Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => PaymentScreen(
          //       product: product,
          //       allProducts: allProducts,
          //     ),
          //   ));
          // }
          else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoPage(
                product: product,
                notPaid: subEndTime.isBefore(DateTime.now()),
                allProducts: allProducts,
              ),
            ));
          }
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
