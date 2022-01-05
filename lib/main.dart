import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meditation_alive/auth/forget_password.dart';
import 'package:meditation_alive/auth/login.dart';
import 'package:meditation_alive/auth/sign_up.dart';
import 'package:meditation_alive/main_screen.dart';
import 'package:meditation_alive/provider/auto_play_provider.dart';
import 'package:meditation_alive/provider/dark_theme_provider.dart';
import 'package:meditation_alive/provider/favs_provider.dart';
import 'package:meditation_alive/provider/notification_preferences.dart';
import 'package:meditation_alive/provider/products.dart';
import 'package:meditation_alive/screens/billingScreen.dart';
import 'package:meditation_alive/services/user_state.dart';
import 'package:meditation_alive/widgets/bottom_bar.dart';
import 'package:meditation_alive/wishlist/wishlist.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notifications",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51JvN23LbLnT1uHuWgwACQH9Gm250Q9FG4q8dZG5EmNR5Brlhysq3DEAiwZLDICwGiotd5Ux1wmJ12zGv4l0xVwtz00tY9V2jDN';

  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  AutoPlayProvider autoPlayChangeProvider = AutoPlayProvider();
  NotificationSetProvider notificationSetProvider = NotificationSetProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
    // UserLocalData().set1stOpen();
    // bool isAutoPlay = UserLocalData().getIsAutoPlay()!;
    // bool isNotificationSet = UserLocalData().getNotification()!;
    // if (isNotificationSet != null && isNotificationSet) {
    //   FirebaseMessaging.instance.subscribeToTopic("meditation_alive");
    //   isNotificationSetGlobal = isNotificationSet;
    // }
    // if (isAutoPlay != null && isAutoPlay) {
    //   isAutoPlayGlobal = isAutoPlay;
    // }
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
              theme: ThemeData(
                  primaryColor: Colors.yellow, accentColor: Colors.orange),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(create: (_) {
                return autoPlayChangeProvider;
              }),
              ChangeNotifierProvider(create: (_) {
                return notificationSetProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, ch) {
                return MaterialApp(
                  title: 'Meditation Alive',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  //initialRoute: '/',
                  routes: {
                    // '/': (ctx) => LandingPage(),
                    // WebhookPaymentScreen.routeName: (ctx) =>
                    //     WebhookPaymentScreen(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    MainScreens.routeName: (ctx) => MainScreens(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    BillingScreen.routeName: (ctx) => BillingScreen(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                  },
                );
              },
            ),
          );
        });
  }
}



// import 'package:volt_arena/screens/home_screen.dart';
// import 'package:volt_arena/screens/introduction_auth_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NavigationPage(),
//     );
//   }
// }

// class NavigationPage extends StatefulWidget {
//   @override
//   _NavigationPageState createState() => _NavigationPageState();
// }

// class _NavigationPageState extends State<NavigationPage> {
//   bool isLoggedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((event) {
//       if (event != null) {
//         setState(() {
//           isLoggedIn = true;
//         });
//       } else {
//         setState(() {
//           isLoggedIn = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoggedIn == false ? IntroductionAuthScreen() : HomeScreen(),
//     );
//   }
// }
