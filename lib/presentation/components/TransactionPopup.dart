import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_5/core/MyWallet.dart';

class TransactionPopup extends StatefulWidget {
  const TransactionPopup({super.key});

  @override
  State<TransactionPopup> createState() => _TransactionPopupState();
}

class _TransactionPopupState extends State<TransactionPopup> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Send Transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Target Address'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String targetAddress = _addressController.text;
            String amount = _amountController.text;
            MyWallet().sendTokensParams(targetAddress, amount);
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}