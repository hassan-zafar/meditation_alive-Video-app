import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/my_icons.dart';
import 'package:meditation_alive/provider/dark_theme_provider.dart';
import 'package:meditation_alive/screens/adminScreens/allUsers.dart';
import 'package:meditation_alive/screens/adminScreens/chatLists.dart';
import 'package:meditation_alive/screens/adminScreens/uploadVideo.dart';
import 'package:meditation_alive/screens/homePage.dart';
import 'package:meditation_alive/screens/search.dart';
import 'package:meditation_alive/screens/user_info.dart';
import 'package:meditation_alive/wishlist/wishlist.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List<Map<String, Object>> _pages;
  ScrollController? _scrollController;
  var top = 0.0;

  @override
  void initState() {
    pages = [
      HomePage(),
      // Search(),
      // WishlistScreen(),
      UserInfoScreen(),
      UserNSearch(),
      ChatLists(),
      UploadProductForm(),
    ];
    //
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
    // getData();
  }

  // void getData() async {
  //   User user = _auth.currentUser!;
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
  //       _name = userDoc.get('name');
  //       _email = user.email!;
  //       _joinedAt = userDoc.get('joinedAt');
  //       _phoneNumber = userDoc.get('phoneNumber');
  //       _userImageUrl = userDoc.get('imageUrl');
  //     });
  //   }
  //   // print("name $_name");
  // }

  int _selectedPageIndex = 0;
  late List pages;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.deepOrange,
              currentIndex: _selectedPageIndex,
              // selectedLabelStyle: TextStyle(fontSize: 16),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.room_service), label: 'For You'),
                // BottomNavigationBarItem(
                //     icon: Icon(
                //       MyAppIcons.search,
                //     ),
                //     label: 'Search'),
                // BottomNavigationBarItem(
                //     icon: Icon(
                //       MyAppIcons.wishlist,
                //     ),
                //     label: 'My Favourites'),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyAppIcons.user,
                    ),
                    label: 'My Profile'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.people,
                    ),
                    label: 'All Users'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat_bubble,
                    ),
                    label: 'Admin Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.upload_file), label: 'Upload Post'),
              ],
            ),
          ),
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

  Widget userTitle({required String title, Color color: Colors.yellow}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color),
      ),
    );
  }
}
