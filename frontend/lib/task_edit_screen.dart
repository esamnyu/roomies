import 'package:flutter/material.dart';

class TaskEditScreen extends StatefulWidget {
  final Map<String, dynamic>? task;

  TaskEditScreen({this.task});

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _timeController;
  late TextEditingController _assignedToController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?['title'] ?? '');
    _descriptionController = TextEditingController(text: widget.task?['description'] ?? '');
    _timeController = TextEditingController(text: widget.task?['time'] ?? '');
    _assignedToController = TextEditingController(text: widget.task?['assignedTo'] ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    _assignedToController.dispose();
    super.dispose();
  }

  void _saveTask() {
    // TODO: Implement task saving logic
    Map<String, dynamic> updatedTask = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'time': _timeController.text,
      'assignedTo': _assignedToController.text,
    };
    
    // Here you would typically send this data to your backend or state management solution
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task saved')),
    );
    Navigator.pop(context, updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Scheduled Time'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _assignedToController,
              decoration: InputDecoration(labelText: 'Assigned To'),
            ),
          ],
        ),
      ),
    );
  }
}