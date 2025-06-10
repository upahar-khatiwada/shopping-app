import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shopping_app/pages/order_placed_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Checkout',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              enableFloatingCard: true,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: showBackView,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            ),
            CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (CreditCardModel creditCardModel) {
                setState(() {
                  cardNumber = creditCardModel.cardNumber;
                  expiryDate = creditCardModel.expiryDate;
                  cardHolderName = creditCardModel.cardHolderName;
                  cvvCode = creditCardModel.cvvCode;
                });
              },
              formKey: formKey,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      title: Text(
                        'Are you sure you want to continue?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Card Number: $cardNumber'),
                            Text('Expiry Date: $expiryDate'),
                            Text('Card Holder Name: $cardHolderName'),
                            Text('CVV: $cvvCode'),
                          ],
                        ),
                      ),
                      contentTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                              Colors.red,
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (BuildContext context) =>
                                    const OrderPlacedPage(),
                              ),
                            );
                          },
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                              Colors.greenAccent,
                            ),
                          ),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.greenAccent,
                ),
                alignment: Alignment.bottomCenter,
              ),
              child: const Text(
                'Confirm Payment!',
                style: TextStyle(
                  // color: Theme.of(context).colorScheme.inversePrimary,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
