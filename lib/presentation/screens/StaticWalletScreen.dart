import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_5/core/MyWallet.dart';
import 'package:flutter_application_5/presentation/components/TransactionPopup.dart';

class StaticWallet extends StatelessWidget {
  static String name = 'StaticWallet Screen';
  const StaticWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return _StaticWallet();
  }
}

class _StaticWallet extends StatefulWidget {
  _StaticWallet({
    super.key,
  });

  @override
  State<_StaticWallet> createState() => _StaticWalletState();
}

class _StaticWalletState extends State<_StaticWallet> {
  MyWallet wallet = new MyWallet();

  String balance = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {
              Clipboard.setData(ClipboardData(text: wallet.credentials.address.toString()));
            }, child: Text(wallet.credentials.address.toString()),),

            Text(balance),

            FilledButton(onPressed: () {
              wallet.getBalance();
              setState(() {
                balance = wallet.balance.toString();
              });
            }, child: const Text('GetBalance')),
            SizedBox(height: 20,),
            FilledButton(onPressed: () {
             showDialog(context: context, builder: (BuildContext contex) {
                return TransactionPopup();
             },
            );
            }, child: Text('SendTransaction')),
            FilledButton(onPressed: () {
              wallet.saveWallet();
            }, child: Text("Yabadubadubdub"))
          ],
          ),
      ),
    );
  }
}