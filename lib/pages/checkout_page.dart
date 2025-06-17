// UNUSED PAGE AFTER IMPLEMENTING STRIPE PAYMENT

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
  CardType? _cardType;
  bool isCardSelected = false;

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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                'Select your payment method: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    child: RadioListTile<CardType>(
                      selectedTileColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      tileColor: Theme.of(context).colorScheme.secondary,
                      activeColor: Theme.of(context).colorScheme.inversePrimary,
                      title: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/cards/master_card.jpg',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'MasterCard',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                      value: CardType.mastercard,
                      groupValue: _cardType,
                      onChanged: (CardType? cardType) {
                        setState(() {
                          _cardType = cardType;
                          isCardSelected = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: RadioListTile<CardType>(
                      selectedTileColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      tileColor: Theme.of(context).colorScheme.secondary,
                      activeColor: Theme.of(context).colorScheme.inversePrimary,
                      title: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/cards/visa.jpg',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Visa',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                      value: CardType.visa,
                      groupValue: _cardType,
                      onChanged: (CardType? cardType) {
                        setState(() {
                          _cardType = cardType;
                          isCardSelected = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: isCardSelected,
                child: CreditCardWidget(
                  enableFloatingCard: true,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: showBackView,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  isHolderNameVisible: true,
                  obscureCardCvv: true,
                  obscureInitialCardNumber: true,
                  isSwipeGestureEnabled: true,
                  cardType: _cardType,
                ),
              ),
              Visibility(
                visible: isCardSelected,
                child: CreditCardForm(
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
                                      OrderPlacedPage(),
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
      ),
    );
  }
}
