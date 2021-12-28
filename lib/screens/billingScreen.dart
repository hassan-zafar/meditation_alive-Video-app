import 'package:flutter/material.dart';
import 'package:meditation_alive/consts/collections.dart';

class BillingScreen extends StatefulWidget {
  static const routeName = '/BillingScreen';

  const BillingScreen({Key? key}) : super(key: key);

  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Monthly Subscription'),
          Text('Next billing date is ${currentUser!.subscriptionEndTIme}')
        ],
      ),
    );
  }
}
