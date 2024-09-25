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
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _consequencesController;
  String _importance = 'High';
  List<String> _importanceLevels = ['Low', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.boundary?['title'] ?? '');
    _descriptionController = TextEditingController(text: widget.boundary?['description'] ?? '');
    _consequencesController = TextEditingController(text: widget.boundary?['consequences'] ?? '');
    _importance = widget.boundary?['importance'] ?? 'High';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _consequencesController.dispose();
    super.dispose();
  }

  void _saveBoundary() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement saving logic (API call, state update, etc.)
      Map<String, dynamic> boundaryData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'importance': _importance,
        'consequences': _consequencesController.text,
      };
      print('Saving boundary: $boundaryData');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub-bucket Detail'),
        actions: [
          TextButton(
            child: Text('Edit', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              // TODO: Implement edit mode
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_titleController.text),
                        SizedBox(height: 16),
                        Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_descriptionController.text),
                        SizedBox(height: 16),
                        Text('Importance', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_importance, style: TextStyle(color: Colors.blue)),
                        SizedBox(height: 16),
                        Text('Consequences', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_consequencesController.text),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  color: Colors.yellow[100],
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Remember, consistent application of this rule helps maintain a respectful living environment for all roommates.',
                            style: TextStyle(color: Colors.orange[800]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}