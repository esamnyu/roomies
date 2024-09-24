import 'package:flutter/material.dart';

// Define a data model for personal space rules
class PersonalSpaceRule {
  final String id;
  final String title;
  final String description;
  final Color borderColor;
  bool isActive;

  PersonalSpaceRule({
    required this.id,
    required this.title,
    required this.description,
    required this.borderColor,
    this.isActive = true,
  });
}

class PersonalSpaceBucket extends StatefulWidget {
  @override
  _PersonalSpaceBucketState createState() => _PersonalSpaceBucketState();
}

class _PersonalSpaceBucketState extends State<PersonalSpaceBucket> {
  List<PersonalSpaceRule> rules = [
    PersonalSpaceRule(
      id: '1',
      title: 'Knock before entering',
      description: 'Always knock and wait for response before entering someone\'s room',
      borderColor: Colors.grey,
    ),
    PersonalSpaceRule(
      id: '2',
      title: 'Respect privacy',
      description: 'Don\'t go through personal belongings without permission',
      borderColor: Colors.blue,
    ),
    PersonalSpaceRule(
      id: '3',
      title: 'Quiet hours',
      description: 'Maintain low noise levels between 10 PM and 7 AM',
      borderColor: Colors.red,
    ),
    PersonalSpaceRule(
      id: '4',
      title: 'Personal items',
      description: 'Ask before borrowing personal items',
      borderColor: Colors.grey,
    ),
  ];

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Personal Space'),
        actions: [
          Switch(
            value: isEditing,
            onChanged: (bool value) {
              setState(() {
                isEditing = value;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.mail_outline),
            onPressed: () {
              // Implement mail action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mail action not implemented yet')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              SizedBox(height: 16),
              ...rules.map((rule) => Column(
                children: [
                  _buildRuleCard(rule),
                  SizedBox(height: 8),
                ],
              )).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: isEditing ? FloatingActionButton(
        onPressed: _addNewRule,
        child: Icon(Icons.add),
      ) : null,
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please respect personal privacy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Actions such as entering room without permission and too much disruption...',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(PersonalSpaceRule rule) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: rule.borderColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    rule.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                if (isEditing) ...[
                  Switch(
                    value: rule.isActive,
                    onChanged: (bool value) {
                      setState(() {
                        rule.isActive = value;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteRule(rule),
                  ),
                ],
              ],
            ),
            SizedBox(height: 4),
            Text(
              rule.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewRule() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = '';
        String newDescription = '';
        return AlertDialog(
          title: Text('Add New Rule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter rule title'),
                onChanged: (value) => newTitle = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter rule description'),
                onChanged: (value) => newDescription = value,
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
                if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                  setState(() {
                    rules.add(PersonalSpaceRule(
                      id: DateTime.now().toString(),
                      title: newTitle,
                      description: newDescription,
                      borderColor: Colors.primaries[rules.length % Colors.primaries.length],
                    ));
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

  void _deleteRule(PersonalSpaceRule rule) {
    setState(() {
      rules.removeWhere((r) => r.id == rule.id);
    });
  }
}