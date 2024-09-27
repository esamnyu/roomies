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
    return Stack(
      children: [
        ListView.builder(
          itemCount: roommates.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(roommates[index]['name']![0]),
              ),
              title: Text(roommates[index]['name']!),
              subtitle: Text(roommates[index]['status']!),
              onTap: () => _navigateToRoommateDetail(context, roommates[index]),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showAddRoommateDialog(context),
            child: Icon(Icons.add),
            tooltip: 'Add New Roommate',
          ),
        ),
      ],
    );
  }

  void _navigateToRoommateDetail(BuildContext context, Map<String, String> roommate) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(roommate['name']!),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${roommate['name']}'),
                Text('Status: ${roommate['status']}'),
                // Add more details as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddRoommateDialog(BuildContext context) {
    String newName = '';
    String newStatus = 'Active';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Roommate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => newName = value,
              ),
              DropdownButton<String>(
                value: newStatus,
                items: ['Active', 'Away', 'Busy'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    newStatus = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (newName.isNotEmpty) {
                  setState(() {
                    roommates.add({'name': newName, 'status': newStatus});
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}