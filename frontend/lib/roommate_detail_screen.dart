import 'package:flutter/material.dart';

class RoommateDetailScreen extends StatefulWidget {
  final Map<String, dynamic> roommate;

  RoommateDetailScreen({required this.roommate});

  @override
  _RoommateDetailScreenState createState() => _RoommateDetailScreenState();
}

class _RoommateDetailScreenState extends State<RoommateDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.roommate['name']);
    _emailController = TextEditingController(text: widget.roommate['email']);
    _phoneController = TextEditingController(text: widget.roommate['phone']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // TODO: Implement API call to save changes
    setState(() {
      widget.roommate['name'] = _nameController.text;
      widget.roommate['email'] = _emailController.text;
      widget.roommate['phone'] = _phoneController.text;
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Roommate details updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Roommate' : 'Roommate Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                widget.roommate['name'][0],
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('Name', _nameController, _isEditing),
            SizedBox(height: 10),
            _buildTextField('Email', _emailController, _isEditing),
            SizedBox(height: 10),
            _buildTextField('Phone', _phoneController, _isEditing),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement navigation to task list filtered for this roommate
              },
              child: Text('View ${widget.roommate['name']}\'s Tasks'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool enabled) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      enabled: enabled,
    );
  }
}