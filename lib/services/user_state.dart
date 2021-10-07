import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditation_alive/auth/landing_page.dart';
import 'package:meditation_alive/consts/collections.dart';
import 'package:meditation_alive/database/database.dart';

import '../main_screen.dart';



class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<User?> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              DatabaseMethods()
                  .fetchUserInfoFromFirebase(uid: userSnapshot.data!.uid);
              print(currentUser);

              print('The user is already logged in');
              return MainScreens();
            } else {
              print('The user didn\'t login yet');
              return
                  // IntroductionAuthScreen();
                  LandingPage();
            }
          } else if (userSnapshot.hasError) {
            return Center(
              child: Text('Error occured'),
            );
          } else {
            return Center(
              child: Text('Error occured'),
            );
          }
        });
  }
}