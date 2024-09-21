import 'package:flutter/material.dart';
import 'task_edit_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Map<String, dynamic> _task;

  @override
  void initState() {
    super.initState();
    _task = Map.from(widget.task);
  }

  void _navigateToEditScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: _task),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _task = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _navigateToEditScreen,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _task['title'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            Text(
              'Scheduled for: ${_task['time']}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              _task['description'] ?? 'No description provided.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Assigned to: ${_task['assignedTo'] ?? 'Unassigned'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement task completion logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task marked as complete')),
                );
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