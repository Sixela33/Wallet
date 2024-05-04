import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_5/presentation/providers/WalletProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletScreen extends StatelessWidget {
  static String name = 'Wallet Screen';
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _WalletScreen();
  }
}

class _WalletScreen extends ConsumerWidget {
  const _WalletScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final walletNotifier = ref.watch(walletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: walletNotifier.credentials.address.toString()));
              } 
            , child: Text(walletNotifier.credentials.address.toString())),
            Text(walletNotifier.balance.toString()),
            FilledButton(onPressed: () {
              walletNotifier.getBalance();
            }, child: Text("getBalance")),
            FilledButton(onPressed: () {
              walletNotifier.sendTokens();
            }, child: Text("Send Tokens!"))
          ],
        ),
      ),
    );
  }
}