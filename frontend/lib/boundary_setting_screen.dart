import 'package:flutter/material.dart';
import 'sub_bucket_detail_screen.dart';

class BoundarySettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildActionButtons(context),
        Expanded(
          child: ListView(
            children: [
              _buildInfoCard(),
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
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // TODO: Implement mail functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.yellow[100],
      margin: EdgeInsets.all(16),
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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Container(
          width: 4,
          height: 40,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          _navigateToSubBucketDetail(context, title);
        },
      ),
    );
  }

  void _navigateToSubBucketDetail(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubBucketDetailScreen(title: title),
      ),
    );
  }
}