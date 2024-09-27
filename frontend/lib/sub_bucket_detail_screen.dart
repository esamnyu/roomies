import 'package:flutter/material.dart';

class SubBucketDetailScreen extends StatelessWidget {
  final String title;

  SubBucketDetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Sub-bucket Detail'),
        actions: [
          TextButton(
            child: Text('Edit', style: TextStyle(color: Colors.white)),
            onPressed: () {
              // TODO: Implement edit functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              _getDescription(title),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Importance',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              _getImportance(title),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _getImportanceColor(title),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Consequences',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              _getConsequences(title),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getReminderColor(title),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.black54),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getReminder(title),
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  String _getDescription(String title) {
    switch (title) {
      case 'Knock before entering':
        return 'Always knock and wait for response before entering someone\'s room';
      case 'Respect privacy':
        return 'Don\'t go through personal belongings without permission';
      case 'Quiet hours':
        return 'Maintain low noise levels between 10 PM and 7 AM';
      case 'Personal items':
        return 'Ask before borrowing personal items';
      default:
        return '';
    }
  }

  String _getImportance(String title) {
    switch (title) {
      case 'Knock before entering':
      case 'Respect privacy':
        return 'High';
      case 'Quiet hours':
        return 'Medium';
      case 'Personal items':
        return 'High';
      default:
        return '';
    }
  }

  Color _getImportanceColor(String title) {
    switch (_getImportance(title)) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  String _getConsequences(String title) {
    switch (title) {
      case 'Knock before entering':
        return 'Violation may result in a house meeting to discuss respect for privacy';
      case 'Respect privacy':
        return 'Violation may result in a serious discussion and potential loss of trust';
      case 'Quiet hours':
        return 'Repeated violations may result in a roommate meeting and potential noise curfews';
      case 'Personal items':
        return 'Repeated violations may result in a serious discussion about boundaries';
      default:
        return '';
    }
  }

  Color _getReminderColor(String title) {
    switch (title) {
      case 'Knock before entering':
      case 'Quiet hours':
        return Colors.yellow.shade100;
      case 'Respect privacy':
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  String _getReminder(String title) {
    switch (title) {
      case 'Knock before entering':
        return 'Remember, consistent application of this rule helps maintain a respectful living environment for all roommates.';
      case 'Respect privacy':
        return 'Remember, respecting each other\'s privacy is crucial for maintaining trust and harmony in a shared living space.';
      case 'Quiet hours':
        return 'Remember, adhering to quiet hours ensures everyone gets the rest they need and promotes a peaceful living environment.';
      case 'Personal items':
        return 'Remember, respecting personal belongings fosters trust and prevents conflicts in shared living spaces.';
      default:
        return '';
    }
  }
}