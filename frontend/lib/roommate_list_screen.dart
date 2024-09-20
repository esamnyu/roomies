import 'package:flutter/material.dart';

class RoommateListScreen extends StatefulWidget {
  @override
  _RoommateListScreenState createState() => _RoommateListScreenState();
}

class _RoommateListScreenState extends State<RoommateListScreen> {
  List<Map<String, dynamic>> roommates = [
    {'id': '1', 'name': 'John Doe', 'email': 'john@example.com', 'phone': '123-456-7890'},
    {'id': '2', 'name': 'Jane Smith', 'email': 'jane@example.com', 'phone': '098-765-4321'},
    // Add more mock data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roommates'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add new roommate screen
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: roommates.length,
        itemBuilder: (context, index) {
          final roommate = roommates[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(roommate['name'][0]),
            ),
            title: Text(roommate['name']),
            subtitle: Text(roommate['email']),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoommateDetailScreen(roommate: roommate),
                ),
              );
            },
          );
        },
      ),
    );
  }
}