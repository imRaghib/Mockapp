import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ------------------- Notification ViewModel -------------------
class NotificationViewModel extends ChangeNotifier {
  int _unreadCount = 3;

  int get unreadCount => _unreadCount;

  void clearNotifications() {
    _unreadCount = 0;
    notifyListeners();
  }

  void fetchNotifications() {
    _unreadCount = 3;
    notifyListeners();
  }
}

/// ------------------- Notification Badge Widget -------------------
class NotificationMenuWidget extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onMenuOpened;

  const NotificationMenuWidget({
    super.key,
    required this.notificationCount,
    required this.onMenuOpened,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications, color: Colors.teal),
          if (notificationCount > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  notificationCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      onOpened: onMenuOpened,
      itemBuilder: (context) => [
        if (notificationCount == 0)
          const PopupMenuItem(
            value: 0,
            child: Text('No new notifications'),
          ),
        if (notificationCount > 0)
          const PopupMenuItem(
            value: 1,
            child: Text('You have new updates'),
          ),
      ],
      onSelected: (value) {
        // Optional: handle click
      },
    );
  }
}

/// ------------------- Live Clock Widget -------------------
class LiveClock extends StatelessWidget {
  const LiveClock({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        final time = snapshot.data ?? DateTime.now();
        final formatted = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
        return Text(
          formatted,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        );
      },
    );
  }
}

/// ------------------- User Menu Widget -------------------
class UserMenuWidget extends StatelessWidget {
  final String userName;

  const UserMenuWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.account_circle, color: Colors.teal, size: 28),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: Text('Logged in as $userName'),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
      onSelected: (value) {
        if (value == 'logout') {
          // Handle logout
        }
      },
    );
  }
}

/// ------------------- Title Bar Widget -------------------
class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);

    return AppBar(
      title: Row(
        children: const [
          Text('H   H I L T E R M A N N'),
          SizedBox(width: 8),
          Text(
            'mDealer',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: LiveClock(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NotificationMenuWidget(
            notificationCount: notificationVM.unreadCount,
            onMenuOpened: notificationVM.clearNotifications,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: UserMenuWidget(userName: 'Arqam Altaf'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
