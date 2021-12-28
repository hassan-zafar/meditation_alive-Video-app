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
      body: expiryDate.isBefore(DateTime.now())
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You Have not purchased any subscription yet',
                  textAlign: TextAlign.center,
                  style: titleTextStyle(color: Theme.of(context).dividerColor),
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Monthly Subscription',
                  textAlign: TextAlign.center,
                  style: titleTextStyle(color: Theme.of(context).dividerColor),
                ),
                Text(
                  'Next billing date is $formattedtime',
                  textAlign: TextAlign.center,
                  style: titleTextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 22),
                )
              ],
            ),
    );
  }
}
