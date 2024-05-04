import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String link;

  const MenuItem({required this.title, required this.subtitle, required this.icon, required this.link});
}

const List<MenuItem> menuItems = [
  MenuItem(
      title: 'wallet', 
      subtitle: 'wallet', 
      icon: Icons.smart_button_outlined, 
      link: '/wallet'
    ),
    MenuItem(
      title: 'Static wallet', 
      subtitle: 'Static wallet', 
      icon: Icons.car_rental_outlined, 
      link: '/staticWallet'
    ),
];
