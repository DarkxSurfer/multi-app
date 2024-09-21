import 'package:flutter/material.dart';
import 'package:multi_app/stripe/payment_service.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  final String amount = "10.00"; // Example amount in dollars
  final String currency = "USD";

  const PaymentScreen({super.key}); // Example currency

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currency),
                const SizedBox(width: 10),
                Text(amount),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                // Convert the dollar amount to cents
                int amountInCents = convertToCents(amount);

                // Initiate the payment process
                await paymentProvider.makePayment(
                    context, amountInCents.toString());
              },
              child: const Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }

  int convertToCents(String amount) {
    // Remove the dollar sign and parse the amount to a double, then convert to cents
    return (double.parse(amount.replaceAll('\$', '').replaceAll(',', '')) * 100)
        .round();
  }
}
