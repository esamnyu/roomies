import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/user_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          subtitle: Text(userProvider.username),
          onTap: () {
            // TODO: Navigate to profile edit screen
            _navigateToSubScreen(context, 'Profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            // TODO: Navigate to notifications settings screen
            _navigateToSubScreen(context, 'Notifications');
          },
        ),
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text('Theme'),
          onTap: () {
            // TODO: Implement theme selection
            _showThemeSelectionDialog(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Help & Support'),
          onTap: () {
            // TODO: Implement help and support
            _navigateToSubScreen(context, 'Help & Support');
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            // TODO: Implement logout functionality
            _showLogoutConfirmationDialog(context);
          },
        ),
      ],
    );
  }

  void _navigateToSubScreen(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Text('$title screen content goes here'),
          ),
        ),
      ),
    );
  }

  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Theme'),
          content: Text('Theme selection functionality to be implemented'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                // TODO: Implement actual logout functionality
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout functionality to be implemented')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}