import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/crypto.dart';
import 'dart:math';
import 'dart:convert';
import 'package:web3dart/web3dart.dart';

class MyWallet {
  late String privateKey;
  late Credentials credentials;
  late Web3Client client;
  late double balance = 0;

  static final MyWallet _instance = MyWallet._internal();

  factory MyWallet() {
    return _instance;
  }

  MyWallet._internal() {
    createNewWallet();
    conectToClient();
    getBalance();
  }

  void createNewWallet() {

    var rng = Random.secure();
    Credentials tempCredentials = EthPrivateKey.createRandom(rng);
    credentials = tempCredentials;
    
    var address = credentials.address;
    print(credentials);
    print(address);
  }

  void conectToClient() {
    try {
      var apiUrl = 'https://holesky.infura.io/v3/e3bb49a966c8473bb7fc7bd57caf3cde';

      var httpClient = Client();
      var ethClient = Web3Client(apiUrl, httpClient);
      client = ethClient;
    } catch (e) {
      print("An error ocurred while conecting to the client");
      print(e);
    }
  
  }

  Future<double?> getBalance() async {
    try {
      var address = this.credentials.address;
      EtherAmount balance = await client.getBalance(address);
      this.balance = balance.getValueInUnit(EtherUnit.ether);
      
      print('Balance: $balance');

      return this.balance;
    } catch (e) {
      print("An error occurred while getting the balance: ");
      print(e);
      return null;
    }
  }


  void saveWallet() async {
    var rng = Random.secure();
    EthPrivateKey pkey =  credentials as EthPrivateKey;
    Wallet wallet = Wallet.createNew(pkey, "password", rng);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('wallet', wallet.toString());
  }

  Future<bool> loadWalletFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String walletData = prefs.getString('wallet') ?? "";

    if(walletData == "") {
      return false;
    }

    walletData = json.decode(walletData);

    Wallet wallet = Wallet.fromJson(walletData, 'password');
    credentials = wallet.privateKey;
    
    return true;
  }

  
  void sendTokens() async {
    try {
      EtherAmount balance = await client.getBalance(credentials.address);
      EtherAmount amountToSend = EtherAmount.inWei(BigInt.parse('10000000'));
      EtherAmount gasPrice = await client.getGasPrice();
      int maxGas = 25000;
      EthereumAddress to = EthereumAddress.fromHex('0x205F6C551094840a2143B2226307AB83e6127901');

      print('Amm to send: $amountToSend');
      print('Gas price: $gasPrice');
      print('Balance: $balance');
      print('Max Gas: $maxGas');
      print('To: $to');
    

      await client.sendTransaction(
        credentials,
        Transaction(
          to: to,
          gasPrice: gasPrice,
          maxGas: maxGas,
          value: amountToSend,
        ),
        chainId:17000
      );
      print("Transaction sent");
      this.getBalance();

    } catch (e) {
      print(e);
    }
  }
  

  sendTokensParams(String sendTo, String sendAmmETH) async {
    try {
      EtherAmount amountToSend = EtherAmount.inWei(BigInt.parse(sendAmmETH));
      EtherAmount gasPrice = await client.getGasPrice();
      var maxGas = await client.estimateGas();
      int intMaxGas = maxGas.toInt();

      EthereumAddress to = EthereumAddress.fromHex(sendTo);

      print('Amm to send: $amountToSend');
      print('Gas price: $gasPrice');
      print('Max Gas: $intMaxGas');
      print('To: $to');
    

      await client.sendTransaction(
        credentials,
        Transaction(
          to: to,
          gasPrice: gasPrice,
          maxGas: intMaxGas,
          value: amountToSend,
        ),
        chainId:17000
      );

    } catch (e) {
      print(e);
    }
  }

}