import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to TaskEditScreen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['title'],
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 16),
            Text(
              'Scheduled for: ${task['time']}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              task['description'] ?? 'No description provided.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 16),
            Text(
              'Assigned to: ${task['assignedTo'] ?? 'Unassigned'}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement task completion logic
              },
              child: Text('Mark as Complete'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}