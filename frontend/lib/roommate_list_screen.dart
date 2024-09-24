import 'package:flutter/material.dart';

class RoommateListScreen extends StatefulWidget {
  @override
  _RoommateListScreenState createState() => _RoommateListScreenState();
}

class _RoommateListScreenState extends State<RoommateListScreen> {
  List<Map<String, String>> roommates = [
    {'name': 'John Doe', 'status': 'Active'},
    {'name': 'Jane Smith', 'status': 'Away'},
    {'name': 'Mike Johnson', 'status': 'Busy'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roommates'),
      ),
      body: ListView.builder(
        itemCount: roommates.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(roommates[index]['name']![0]),
            ),
            title: Text(roommates[index]['name']!),
            subtitle: Text(roommates[index]['status']!),
            onTap: () {
              // TODO: Navigate to roommate detail screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${roommates[index]['name']}')),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new roommate functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Add new roommate functionality not implemented yet')),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Roommate',
      ),
    );
  }
}