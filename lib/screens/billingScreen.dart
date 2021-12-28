import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/collections.dart';
import 'package:meditation_alive/consts/consants.dart';

class BillingScreen extends StatefulWidget {
  static const routeName = '/BillingScreen';

  const BillingScreen({Key? key}) : super(key: key);

  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  DateTime expiryDate = DateTime.parse(currentUser!.subscriptionEndTIme!);
  @override
  Widget build(BuildContext context) {
    String formattedtime =
        '${expiryDate.day}/${expiryDate.month}/${expiryDate.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Billing'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Monthly Subscription',
            style: titleTextStyle(color: Colors.white),
          ),
          Text(
            'Next billing date is $formattedtime',
            style: titleTextStyle(color: Colors.white, fontSize: 22),
          )
        ],
      ),
    );
  }
}
