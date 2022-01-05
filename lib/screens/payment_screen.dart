import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meditation_alive/consts/collections.dart';
import 'package:meditation_alive/consts/consants.dart';
import 'package:meditation_alive/models/product.dart';
import 'package:meditation_alive/models/users.dart';
import 'package:meditation_alive/screens/videoPage.dart';

class PaymentScreen extends StatefulWidget {
  final Product? product;
  final List<Product>? allProducts;
  PaymentScreen({required this.product, this.allProducts});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Unlock ',
                    style:
                        titleTextStyle(context: context, color: Colors.white),
                  ),
                  Image.asset(
                    logo,
                    height: 60,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.done),
                  Text(
                    'Access to hundreds powerful guided meditations',
                    // style: titleTextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.done),
                  Text(
                    'New Content added daily',
                    // style: titleTextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(Icons.done),
                Text(
                  'Meditations for every mood and goal',
                  // style: titleTextStyle(color: Colors.white),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.done),
                  Text(
                    'Exclusive access to all Moving Meditations',
                  ),
                ],
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    DateTime subEndTime =
                        DateTime.parse(currentUser!.subscriptionEndTIme!);
                    if (subEndTime.isBefore(DateTime.now())) {
                      await makePayment(widget.product!, widget.allProducts!);
                    } else {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoPage(
                          product: widget.product,
                          notPaid: subEndTime.isBefore(DateTime.now()),
                          allProducts: widget.allProducts,
                        ),
                      ));
                    }
                  },
                  child: Container(
                    // height: 50,
                    // width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        gradient: LinearGradient(colors: [
                          Colors.limeAccent,
                          Colors.orange,
                          Colors.orange
                        ]),
                        borderRadius: BorderRadius.circular(
                          20,
                        )),
                    padding: EdgeInsets.all(20), margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'MONTHLY',
                          style: titleTextStyle(
                            context: context,
                          ),
                        ),
                        Text(
                          'Pay 9.99/Mo',
                          style: titleTextStyle(
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(Product product, List<Product> allProducts) async {
    try {
      paymentIntentData = await createPaymentIntent('10', 'USD');
      //json.decode(response.body);
      print(paymentIntentData!['amount']);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(product, allProducts);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(Product product, List<Product> allProducts) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        userRef.doc(currentUser!.id).update({
          'subscriptionEndTIme':
              DateTime.now().add(Duration(days: 30)).toIso8601String()
        });
        var doc = await userRef.doc(currentUser!.id).get();
        currentUser = AppUserModel.fromDocument(doc);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));
        DateTime subEndTime = DateTime.parse(currentUser!.subscriptionEndTIme!);
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPage(
            product: product,
            notPaid: subEndTime.isBefore(DateTime.now()),
            allProducts: allProducts,
          ),
        ));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('10'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51JvN23LbLnT1uHuWUJahSXKDn2LO7cZG4cciGVCw1tUrvEQT6W2kNyOdEhFyCEiwDIwm3mnFMeTbT6hqVWkxcp8V00jAv01FBf',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
