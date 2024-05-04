import 'package:flutter_application_5/presentation/screens/HomeScreen.dart';
import 'package:flutter_application_5/presentation/screens/StaticWalletScreen.dart';
import 'package:flutter_application_5/presentation/screens/WalletScreen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: StaticWallet.name,
      path: '/staticWallet',
      builder: (context, state) => const StaticWallet(),
    ),
    GoRoute(
      name: WalletScreen.name,
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
  ]
);