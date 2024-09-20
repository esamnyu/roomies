import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalSpaceBucket extends StatefulWidget {
  @override
  _PersonalSpaceBucketState createState() => _PersonalSpaceBucketState();
}

class _PersonalSpaceBucketState extends State<PersonalSpaceBucket> {
  bool isEditing = false;

  final List<Map<String, dynamic>> subBuckets = [
    {
      "title": "Knock before entering",
      "description": "Always knock and wait for response before entering someone's room",
      "color": Colors.grey[300],
    },
    {
      "title": "Respect privacy",
      "description": "Don't go through personal belongings without permission",
      "color": Colors.blue[500],
    },
    {
      "title": "Quiet hours",
      "description": "Maintain low noise levels between 10 PM and 7 AM",
      "color": Colors.red[500],
    },
    {
      "title": "Personal items",
      "description": "Ask before borrowing personal items",
      "color": Colors.grey[300],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Status bar
            Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10:31', style: TextStyle(color: Colors.white, fontSize: 12)),
                  Row(
                    children: List.generate(3, (index) => 
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back, size: 24),
                      SizedBox(width: 8),
                      Text('Personal Space', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => isEditing = !isEditing),
                        child: Row(
                          children: [
                            Text('CRUD switch', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                            SizedBox(width: 4),
                            Icon(Icons.edit, size: 16, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Stack(
                        children: [
                          Icon(Icons.mail, size: 24, color: Colors.orange),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Main content
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  // Main bucket description
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please respect personal privacy',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Actions such as entering room without permission and too much disruption...',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Sub-buckets
                  ...subBuckets.map((bucket) => 
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: bucket['color'], width: 4)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bucket['title'], style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text(bucket['description'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
            ),
            // Bottom navigation
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home),
                  Icon(Icons.file_copy),
                  Icon(Icons.attach_money),
                  Icon(Icons.message),
                  Icon(Icons.more_horiz),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}