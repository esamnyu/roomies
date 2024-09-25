import 'package:flutter/material.dart';

class BoundarySettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boundary Setting'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // TODO: Implement email functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildInfoCard(),
          _buildBoundaryItem('Knock before entering', 'Always knock and wait for response before entering someone\'s room'),
          _buildBoundaryItem('Respect privacy', 'Don\'t go through personal belongings without permission'),
          _buildBoundaryItem('Quiet hours', 'Maintain low noise levels between 10 PM and 7 AM'),
          _buildBoundaryItem('Personal items', 'Ask before borrowing personal items'),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
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

  Widget _buildBoundaryItem(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        leading: Container(
          width: 4,
          color: Colors.blue,
        ),
      ),
    );
  }
}