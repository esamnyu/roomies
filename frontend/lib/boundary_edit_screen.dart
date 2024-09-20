import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/user_provider.dart';

class BoundaryEditScreen extends StatefulWidget {
  final Map<String, dynamic>? boundary;

  BoundaryEditScreen({this.boundary});

  @override
  _BoundaryEditScreenState createState() => _BoundaryEditScreenState();
}

class _BoundaryEditScreenState extends State<BoundaryEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  String _importance = 'Medium';
  List<String> _importanceLevels = ['Low', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.boundary?['name'] ?? '');
    _descriptionController = TextEditingController(text: widget.boundary?['description'] ?? '');
    _importance = widget.boundary?['importance'] ?? 'Medium';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveBoundary() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement saving logic (API call, state update, etc.)
      Map<String, dynamic> boundaryData = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'importance': _importance,
      };
      print('Saving boundary: $boundaryData');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boundary == null ? 'Add Boundary' : 'Edit Boundary'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBoundary,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Boundary Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a boundary name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _importance,
              decoration: InputDecoration(
                labelText: 'Importance',
                border: OutlineInputBorder(),
              ),
              items: _importanceLevels.map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _importance = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveBoundary,
              child: Text('Save Boundary'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}