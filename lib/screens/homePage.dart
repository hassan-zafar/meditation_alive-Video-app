import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/screens/search.dart';
import 'package:meditation_alive/screens/user_info.dart';
import 'package:meditation_alive/screens/videoPage.dart';
import 'package:meditation_alive/widgets/commentsNChat.dart';

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
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
                        child: Container(
                          width: 250,
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  "https://www.psypost.org/wp-content/uploads/2021/07/meditation-750x375.jpg"),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0x9839D2C0),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xFF1E2429),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Super Human Boost',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            'Seated Medication',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '7 min',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFD6D6D6),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'Ambient',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFD6D6D6),
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
                        child: Container(
                          width: 250,
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  "https://www.psypost.org/wp-content/uploads/2021/07/meditation-750x375.jpg"),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0x9839D2C0),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xFF1E2429),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Super Human Boost',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            'Seated Medication',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '7 min',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFD6D6D6),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'Ambient',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFD6D6D6),
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItemsViewer(
                      path:
                          "https://firebasestorage.googleapis.com/v0/b/medication-alive.appspot.com/o/videos%2FDaily%2FEvening_mediation.mp4?alt=media&token=ebd8c676-b1c7-4820-9d36-640aeacfe208",
                      postId: "daily1stVid",
                      category: 'Daily',
                      videoLength: "10 min",
                      videoText: "Movement Running Meditation",
                    ),
                  ],
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItemsViewer(
                      path:
                          "https://firebasestorage.googleapis.com/v0/b/medication-alive.appspot.com/o/videos%2FMovement%2FMovement_Running_Meditation.mp4?alt=media&token=d1c432bf-e932-42d0-9802-7d86b04c96ed",
                      postId: "movement1stVid",
                      category: 'Movement',
                      videoLength: "10 min",
                      videoText: "Movement Running Meditation",
                    ),
                  ],
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItemsViewer(
                      path:
                          "https://firebasestorage.googleapis.com/v0/b/medication-alive.appspot.com/o/videos%2FSeated%2FCharkra_Clearing_Meditation.mp4?alt=media&token=7261212b-bff2-4d1a-a5c9-844b198e703c",
                      postId: "seated1stVid",
                      category: 'Seated',
                      videoLength: "12 min",
                      videoText: "Charkra Clearing Meditation",
                    ),
                  ],
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItemsViewer(
                      path:
                          "https://firebasestorage.googleapis.com/v0/b/medication-alive.appspot.com/o/videos%2FThinking%2FSelf_Value.mp4?alt=media&token=e4822ed2-cda2-48c7-83b6-04f3eb6d4a80",
                      postId: "thinking1stVid",
                      videoLength: "32 min",
                      videoText: "Self Value",
                      category: 'Thinking',
                    ),
                  ],
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItemsViewer(
                      path:
                          "https://firebasestorage.googleapis.com/v0/b/medication-alive.appspot.com/o/videos%2FEducation%2FLetting_go_of_Negativity.mp4?alt=media&token=cb9db466-94dd-4d76-946e-0a07b80851f3",
                      postId: "education1stVid",
                      videoLength: "17 min",
                      videoText: "Letting go of Negativity",
                      category: 'Education',
                    ),
                  ],
                ),
              ),
            ],
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
    return Text(
      categoryName!,
      style: TextStyle(
        fontFamily: 'Lexend Deca',
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CategoryItemsViewer extends StatelessWidget {
  final String? path;
  final String? postId;
  final String? videoLength;
  final String? videoText;
  final String? category;

  const CategoryItemsViewer(
      {this.path,
      this.postId,
      this.videoLength,
      this.category,
      this.videoText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VideoPage(
              path: path,
              postId: postId,
              category: category,
              videoTitle: videoText,
            ),
          ));
        },
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
          child: Container(
            width: 145,
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(
                    "https://images.ctfassets.net/qpn1gztbusu2/6CRBRq6rVbvNSNoHB0pCT1/3fce2bfcdd96ff2842b68d41cdd4e008/Livre-Audio-Meditation.jpg"),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFF1E2429),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          videoText!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 12,
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
                                fontSize: 10,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          Text(
                            'Guitar',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFF5F5F5),
                              fontSize: 10,
                              fontWeight: FontWeight.w100,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
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

void _about(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'chips_choice',
              style: TextStyle(color: Colors.black87),
            ),
            subtitle: const Text('by davigmacode'),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Easy way to provide a single or multiple choice chips.',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
