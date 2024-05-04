import 'package:flutter_application_5/core/MyWallet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletProvider = StateNotifierProvider<WalletNotifier, MyWallet>((ref) {
  final walletNotifier = WalletNotifier();
  // Fetch initial balance immediately after the provider is created
  walletNotifier.updateBalance();
  return walletNotifier;
});
class WalletNotifier extends StateNotifier<MyWallet> {
  WalletNotifier() : super(MyWallet());

  String getWalletAddress() {
    return state.credentials.address.toString();
  }

  Future<double?> getWalletBalance() async {
    try {
      var res = await state.getBalance();
      return res;
    } catch (e) {
      return 0;
    }
  }

  Future<void> updateBalance() async {
      try {
        await state.getBalance();
        // Notify listeners after updating the balance
        state = state;
      } catch (e) {
        print("Error updating balance: $e");
      }
    }

  Future<bool> sendTokens(String sendTo, String sendAmmETH) async {
    try {
      await state.sendTokensParams(sendTo, sendAmmETH);
      // Update balance after sending tokens
      await updateBalance();
      return true;
    } catch (e) {
      print("Error sending tokens: $e");
      return false;
    }
  }
}