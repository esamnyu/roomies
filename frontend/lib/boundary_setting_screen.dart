import 'package:flutter/material.dart';
import 'sub_bucket_detail_screen.dart';

class BoundarySettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building BoundarySettingScreen'); // Debug print
    return Scaffold(
      appBar: AppBar(
        title: Text('Boundary Setting'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print('Edit button pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              print('Mail button pressed');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildInfoCard(), // Add this line
          _buildBoundaryItem(
            context,
            'Knock before entering',
            'Always knock and wait for response before entering someone\'s room',
          ),
          _buildBoundaryItem(
            context,
            'Respect privacy',
            'Don\'t go through personal belongings without permission',
          ),
          _buildBoundaryItem(
            context,
            'Quiet hours',
            'Maintain low noise levels between 10 PM and 7 AM',
          ),
          _buildBoundaryItem(
            context,
            'Personal items',
            'Ask before borrowing personal items',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.yellow[100],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Boundaries are rules that help maintain a healthy living environment. Tap on a boundary to view more details.',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBoundaryItem(BuildContext context, String title, String description) {
    return GestureDetector(
      onTap: () {
        print('Tapped on: $title'); // Debug print
        _navigateToSubBucketDetail(context, title);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                color: Colors.blue,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(description),
                  ],
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSubBucketDetail(BuildContext context, String title) {
    print('Navigating to SubBucketDetailScreen for: $title'); // Debug print
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubBucketDetailScreen(title: title),
      ),
    );
  }
}