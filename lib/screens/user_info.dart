import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:meditation_alive/consts/collections.dart';
import 'package:meditation_alive/consts/colors.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/consts/my_icons.dart';
import 'package:meditation_alive/database/database.dart';
import 'package:meditation_alive/models/users.dart';
import 'package:meditation_alive/provider/auto_play_provider.dart';
import 'package:meditation_alive/provider/dark_theme_provider.dart';
import 'package:meditation_alive/provider/notification_preferences.dart';
import 'package:meditation_alive/screens/adminScreens/commentsNChatAdmin.dart';
import 'package:meditation_alive/screens/billingScreen.dart';
import 'package:meditation_alive/widgets/loadingWidget.dart';
import 'package:meditation_alive/wishlist/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  ScrollController? _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // String? _uid;
  // String? _name;
  // String? _email;
  // String? _joinedAt;
  // String? _userImageUrl;
  // int? _phoneNumber;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
    // getData();
  }

  // void getData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   User user = DatabaseMethods().fetchUserInfoFromFirebase(uid: uid);
  //   _uid = user.uid;

  //   print('user.displayName ${user.displayName}');
  //   print('user.photoURL ${user.photoURL}');
  //   DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
  //       ? null
  //       : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  //   // .then((value) {
  //   // if (user.isAnonymous) {
  //   //   userDoc = null;
  //   // } else {
  //   //   userDoc = value;
  //   // }
  //   // });
  //   if (userDoc == null) {
  //     return;
  //   } else {
  //     setState(() {
  //       currentUser = AppUserModel.fromDocument(userDoc);
  //       _name = userDoc.get('name');
  //       _email = user.email!;
  //       _joinedAt = userDoc.get('joinedAt');
  //       _phoneNumber = userDoc.get('phoneNumber');
  //       _userImageUrl = userDoc.get('imageUrl');
  //       isLoading = false;
  //     });
  //   }

  //   // print("name $_name");
  // }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final autoPlayChange = Provider.of<AutoPlayProvider>(context);
    final notificationChange = Provider.of<NotificationSetProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? LoadingIndicator()
            : Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        // leading: Icon(Icons.ac_unit_outlined),
                        // automaticallyImplyLeading: false,
                        elevation: 0,
                        expandedHeight: 250,
                        pinned: true,
                        flexibleSpace: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          top = constraints.biggest.height;

                          return Container(
                            decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //     colors: [
                                //       ColorsConsts.starterColor,
                                //       ColorsConsts.endColor,
                                //     ],
                                //     begin: const FractionalOffset(0.0, 0.0),
                                //     end: const FractionalOffset(1.0, 0.0),
                                //     stops: [0.0, 1.0],
                                //     tileMode: TileMode.clamp),
                                ),
                            child: FlexibleSpaceBar(
                              // collapseMode: CollapseMode.parallax,
                              centerTitle: true,
                              title: AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: top <= 110.0 ? 1.0 : 0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: kToolbarHeight / 1.8,
                                      width: kToolbarHeight / 1.8,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      // 'top.toString()',
                                      currentUser!.name! == null ? 'Guest' : currentUser!.name!,
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              background: Column(
                                children: [
                                  Text(
                                    "Settings",
                                    style: titleTextStyle(
                                        context: context, color: Colors.white),
                                  ),
                                  CircleAvatar(
                                    maxRadius: 50,
                                    minRadius: 30,
                                    backgroundImage: NetworkImage(
                                        'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                                  ),
                                  Text(
                                    currentUser!.name! == null ? 'Guest' : currentUser!.name!,
                                    style: titleTextStyle(
                                        context: context,
                                        fontSize: 20,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  Text(
                                    currentUser!.email! == null ? 'Guest' : currentUser!.email!,
                                    style: titleTextStyle(
                                        context: context,
                                        fontSize: 16,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text("Edit Profile"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userTitle(title: 'Content'),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(WishlistScreen.routeName),
                                splashColor: Colors.red,
                                child: ListTile(
                                  title: Text('Favourite'),
                                  trailing: Icon(Icons.chevron_right_rounded),
                                  leading: Icon(MyAppIcons.wishlist),
                                ),
                              ),
                            ),
                            // Material(
                            //   color: Colors.transparent,
                            //   child: InkWell(
                            //     onTap: () => Navigator.of(context)
                            //         .pushNamed(WishlistScreen.routeName),
                            //     splashColor: Colors.red,
                            //     child: ListTile(
                            //       title: Text('Downloads'),
                            //       trailing: Icon(Icons.chevron_right_rounded),
                            //       leading:
                            //           Icon(Icons.download_for_offline_rounded),
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8.0),
                            //   child: userTitle(title: 'User Information'),
                            // ),
                            // Divider(
                            //   thickness: 1,
                            //   color: Colors.grey,
                            // ),
                            // userListTile('Email', _email ?? '', 0, context),
                            // userListTile('Phone number',
                            //     _phoneNumber.toString(), 1, context),
                            // // userListTile('Shipping address', '', 2, context),
                            // userListTile(
                            //     'joined date', _joinedAt ?? '', 3, context),

                            userTitle(title: 'User preferences'),

                            ListTile(
                              onTap: () => Share.share(
                                  'check out this app https://play.google.com/store/apps/details?id=com.whatsapp',
                                  subject: 'Look at this app!'),
                              title: Text("Invite a Friend"),
                              trailing: Icon(Icons.chevron_right_rounded),
                              leading: Icon(
                                Icons.person_add,
                                color: Colors.yellow,
                              ),
                            ),
                            ListTileSwitch(
                              value: autoPlayChange.autoPlay,
                              leading: Icon(Icons.refresh),
                              onChanged: (value) {
                                print(value);

                                setState(() {
                                  autoPlayChange.autoPlay = value;
                                });
                              },
                              visualDensity: VisualDensity.comfortable,
                              switchType: SwitchType.cupertino,
                              switchActiveColor: Colors.indigo,
                              title: Text('Auto Play'),
                            ),
                            ListTileSwitch(
                              value: notificationChange.notificationSet,
                              leading: Icon(Icons.notifications),
                              onChanged: (value) {
                                setState(() {
                                  notificationChange.notificationSet = value;
                                });
                              },
                              visualDensity: VisualDensity.comfortable,
                              switchType: SwitchType.cupertino,
                              switchActiveColor: Colors.indigo,
                              title: Text('Allow Notifications'),
                            ),
                            ListTileSwitch(
                              value: themeChange.darkTheme,
                              leading: Icon(FontAwesomeIcons.moon),
                              onChanged: (value) {
                                setState(() {
                                  themeChange.darkTheme = value;
                                });
                              },
                              visualDensity: VisualDensity.comfortable,
                              switchType: SwitchType.cupertino,
                              switchActiveColor: Colors.indigo,
                              title: Text('Dark theme'),
                            ),
                            userTitle(title: "Account"),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(BillingScreen.routeName),
                                splashColor: Colors.red,
                                child: ListTile(
                                  title: Text('Billing'),
                                  trailing: Icon(Icons.chevron_right_rounded),
                                  leading: Icon(Icons.credit_card),
                                ),
                              ),
                            ),
                            currentUser!.isAdmin!
                                ? Container()
                                : Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            CommentsNChatAdmin(
                                          chatId: currentUser!.id,
                                          chatNotificationToken: currentUser!
                                              .androidNotificationToken,
                                        ),
                                      )),
                                      splashColor: Colors.red,
                                      child: ListTile(
                                        title: Text('Report a Problem'),
                                        trailing:
                                            Icon(Icons.chevron_right_rounded),
                                        leading: Icon(Icons.flag),
                                      ),
                                    ),
                                  ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Theme.of(context).splashColor,
                                child: ListTile(
                                  onTap: () async {
                                    // Navigator.canPop(context)? Navigator.pop(context):null;
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 6.0),
                                                  child: Image.network(
                                                    'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text('Sign out'),
                                                ),
                                              ],
                                            ),
                                            content:
                                                Text('Do you wanna Sign out?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel')),
                                              TextButton(
                                                  onPressed: () async {
                                                    await _auth.signOut().then(
                                                        (value) =>
                                                            Navigator.pop(
                                                                context));
                                                  },
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          );
                                        });
                                  },
                                  title: Text('Logout'),
                                  leading: Icon(Icons.exit_to_app_rounded),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // _buildFab()
                ],
              ),
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController!.hasClients) {
      double offset = _scrollController!.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down

        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down

        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      leading: Icon(_userTileIcons[index]),
    );
  }

  Widget userTitle({required String title}) {
    return Container(
      width: double.maxFinite,
      color: Colors.teal,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
      ),
    );
  }
}
