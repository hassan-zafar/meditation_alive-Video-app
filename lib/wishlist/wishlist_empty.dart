import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/colors.dart';
import 'package:meditation_alive/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class WishlistEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 120),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/empty-wishlist.png'),
              ),
            ),
          ),
          Text(
            'Your Favourites are Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
                color:Colors.black,
                //  Theme.of(context).secondaryHeaderColor,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Explore more and shortlist some items',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Theme.of(context).disabledColor
                    : ColorsConsts.subTitle,
                // fontSize: 26,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
              onPressed: () => {
                // Navigator.of(context).pushNamed(Feeds.routeName),
              },
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(16),
              //   side: BorderSide(color: Colors.red),
              // ),
              // color: Colors.yellow,
              child: Text(
                'Add to favourite'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
