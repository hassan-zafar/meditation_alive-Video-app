import 'package:flutter/material.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/widgets/feeds_products.dart';
import 'package:meditation_alive/widgets/searchby_header.dart';
import 'package:provider/provider.dart';


import '../consts/colors.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController? _searchTextController;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController!.dispose();
  }

    // Container(
    //             width: MediaQuery.of(context).size.width,
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 fit: BoxFit.fitWidth,
    //                 image: CachedNetworkImageProvider(
    //                     "https://resize.prod.femina.ladmedia.fr/rblr/652,438/img/var/2020-03/exercice-de-meditation-pleine-conscience.jpg"),
    //               ),
    //               boxShadow: [
    //                 BoxShadow(
    //                   blurRadius: 4,
    //                   color: Colors.transparent,
    //                   offset: Offset(0, 2),
    //                 )
    //               ],
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(16),
    //                 bottomRight: Radius.circular(16),
    //                 topLeft: Radius.circular(0),
    //                 topRight: Radius.circular(0),
    //               ),
    //             ),
    //             child: Container(
    //               width: 100,
    //               decoration: BoxDecoration(
    //                 gradient: LinearGradient(
    //                   colors: [Color(0xFF1E2429), Color(0x00111417)],
    //                   stops: [0, 1],
    //                   begin: AlignmentDirectional(0, -1),
    //                   end: AlignmentDirectional(0, 1),
    //                 ),
    //                 borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(16),
    //                   bottomRight: Radius.circular(16),
    //                   topLeft: Radius.circular(0),
    //                   topRight: Radius.circular(0),
    //                 ),
    //               ),
    //               child: Padding(
    //                 padding: EdgeInsetsDirectional.fromSTEB(16, 56, 16, 0),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.max,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       mainAxisSize: MainAxisSize.max,
    //                       children: [
    //                         Text(
    //                           'Hey',
    //                           style: TextStyle(
    //                             fontFamily: 'Lexend Deca',
    //                             color: Colors.white,
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.normal,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
    //                           child: Text(
    //                             'Alex',
    //                             style: TextStyle(
    //                               fontFamily: 'Lexend Deca',
    //                               color: Color(0xFFEE8B60),
    //                               fontSize: 14,
    //                               fontWeight: FontWeight.normal,
    //                             ),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
    //                       child: Text(
    //                         'Discover',
    //                         style: TextStyle(
    //                           fontFamily: 'Lexend Deca',
    //                           color: Colors.white,
    //                           fontSize: 24,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 12),
    //                       child: Container(
    //                         width: MediaQuery.of(context).size.width * 0.96,
    //                         height: 50,
    //                         decoration: BoxDecoration(
    //                           color: Color(0x9AFFFFFF),
    //                           borderRadius: BorderRadius.circular(8),
    //                         ),
    //                         child: Row(
    //                           mainAxisSize: MainAxisSize.max,
    //                           children: [
    //                             Expanded(
    //                               child: Padding(
    //                                 padding: EdgeInsetsDirectional.fromSTEB(
    //                                     16, 0, 0, 0),
    //                                 child: TextFormField(
    //                                   controller: textController,
    //                                   obscureText: false,
    //                                   decoration: InputDecoration(
    //                                     hintText: 'Search here',
    //                                     hintStyle: TextStyle(
    //                                       fontFamily: 'Lexend Deca',
    //                                       color: Color(0xFF1A1F24),
    //                                       fontSize: 14,
    //                                       fontWeight: FontWeight.normal,
    //                                     ),
    //                                     enabledBorder: UnderlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                         color: Color(0x00000000),
    //                                         width: 1,
    //                                       ),
    //                                       borderRadius: const BorderRadius.only(
    //                                         topLeft: Radius.circular(4.0),
    //                                         topRight: Radius.circular(4.0),
    //                                       ),
    //                                     ),
    //                                     focusedBorder: UnderlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                         color: Color(0x00000000),
    //                                         width: 1,
    //                                       ),
    //                                       borderRadius: const BorderRadius.only(
    //                                         topLeft: Radius.circular(4.0),
    //                                         topRight: Radius.circular(4.0),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   style: TextStyle(
    //                                     fontFamily: 'Lexend Deca',
    //                                     color: Color(0xFF1A1F24),
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.normal,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Card(
    //                               clipBehavior: Clip.antiAliasWithSaveLayer,
    //                               color: Color(0xFF1E2429),
    //                               shape: RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(8),
    //                               ),
    //                               child: IconButton(
    //                                 padding: EdgeInsets.all(12),
    //                                 icon: Icon(
    //                                   Icons.search_outlined,
    //                                   color: Colors.white,
    //                                   size: 24,
    //                                 ),
    //                                 onPressed: () {
    //                                   print('IconButton pressed ...');
    //                                 },
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Chip(
    //                   label: Text("Movement"),
    //                   // labelPadding: EdgeInsets.all(8),
    //                 ),
    //                 Chip(
    //                   label: Text("Daily"),
    //                   // labelPadding: EdgeInsets.all(8),
    //                 ),
    //                 Chip(
    //                   label: Text("Seated"),
    //                   // labelPadding: EdgeInsets.all(8),
    //                 ),
    //                 Chip(
    //                   label: Text("Educational"),
    //                   // labelPadding: EdgeInsets.all(8),
    //                 ),
    //                 Chip(
    //                   label: Text("Thinking"),
    //                   // labelPadding: EdgeInsets.all(8),
    //                 ),
    //               ],
    //             ),
    //           ),
             



  List<Product> _searchList = [];
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productsList = productsData.products;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: 
            SearchByHeader(
              stackPaddingTop: 175,
              titlePaddingTop: 50,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsConsts.title,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              stackChild: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: _searchTextController!.text.isEmpty
                          ? null
                          : () {
                              _searchTextController!.clear();
                              _node.unfocus();
                            },
                      icon: Icon(Icons.remove_from_queue,
                          color: _searchTextController!.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    _searchTextController!.text.toLowerCase();
                    setState(() {
                      _searchList = productsData.searchQuery(value);
                    });
                  },
                ),
              ),
            ),
        
          ),
          SliverToBoxAdapter(
            child: _searchTextController!.text.isNotEmpty && _searchList.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.search,
                        size: 60,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'No results found',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 12,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                        _searchTextController!.text.isEmpty
                            ? productsList.length
                            : _searchList.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: _searchTextController!.text.isEmpty
                            ? productsList[index]
                            : _searchList[index],
                        child: FeedProducts(),
                      );
                    }),
                  ),
          ),
        ],
      ),
    );
  }
}
