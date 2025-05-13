// step 1- import 'widgets/user_menu_widget.dart'; s
//step 2- const UserMenuWidget(userName: 'John Doe'),
import 'package:flutter/material.dart';

class UserMenuWidget extends StatelessWidget {
  final String userName;

  const UserMenuWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.person, color: Colors.white),
      ),
      onSelected: (item) => handleMenuClick(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ),
      ],
    );
  }

  void handleMenuClick(BuildContext context, int item) {
    switch (item) {
      case 0:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile clicked')),
        );
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings clicked')),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout clicked')),
        );
        // TODO: Add logout logic here if needed
        break;
    }
  }
}
