import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notification> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    // TODO: Replace with actual API call
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    setState(() {
      notifications = [
        Notification(id: '1', title: 'New task assigned', message: 'You have been assigned a new task: Clean the kitchen', timestamp: DateTime.now().subtract(Duration(hours: 1))),
        Notification(id: '2', title: 'Boundary reminder', message: 'Quiet hours start in 30 minutes', timestamp: DateTime.now().subtract(Duration(hours: 3))),
        Notification(id: '3', title: 'Expense added', message: 'John added a new expense: Groceries \$50', timestamp: DateTime.now().subtract(Duration(days: 1))),
      ];
      isLoading = false;
    });
  }

  Future<void> _refreshNotifications() async {
    setState(() {
      isLoading = true;
    });
    await _fetchNotifications();
  }

  void _markAsRead(String id) {
    // TODO: Implement mark as read functionality
    print('Marked notification $id as read');
  }

  void _deleteNotification(String id) {
    setState(() {
      notifications.removeWhere((notification) => notification.id == id);
    });
    // TODO: Implement delete notification API call
    print('Deleted notification $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              // TODO: Implement clear all notifications
              print('Clear all notifications');
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshNotifications,
              child: notifications.isEmpty
                  ? Center(child: Text('No notifications'))
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Dismissible(
                          key: Key(notification.id),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _deleteNotification(notification.id);
                          },
                          child: ListTile(
                            title: Text(notification.title),
                            subtitle: Text(notification.message),
                            trailing: Text(
                              '${notification.timestamp.hour}:${notification.timestamp.minute}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            onTap: () => _markAsRead(notification.id),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}

class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
  });
}