import 'package:flutter/material.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual task count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Task ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(task: {}), // Pass actual task data
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new task functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}