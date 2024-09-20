import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'auth/user_provider.dart';
import 'boundary_edit_screen.dart';
import 'task_detail_screen.dart';
import 'task_edit_screen.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  late IO.Socket socket;
  List<Map<String, dynamic>> todaySchedule = [];
  List<Map<String, dynamic>> recentNotifications = [];
  List<Map<String, dynamic>> boundaries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSocket();
    _fetchDashboardData();
  }

  void _initializeSocket() {
    socket = IO.io('SERVER_URL', <String, dynamic>{
      'transports': ['websocket'],
    });
    
    socket.on('taskUpdate', (data) {
      setState(() {
        // Update tasks in the state
        // For example: todaySchedule = List<Map<String, dynamic>>.from(data['tasks']);
      });
    });
    
    socket.on('notificationUpdate', (data) {
      setState(() {
        // Update notifications in the state
        // For example: recentNotifications = List<Map<String, dynamic>>.from(data['notifications']);
      });
    });
  }

  Future<void> _fetchDashboardData() async {
    setState(() => isLoading = true);
    try {
      // TODO: Replace with actual API calls
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        todaySchedule = [
          {'id': '1', 'time': '09:00 AM', 'title': 'Clean Kitchen', 'description': 'Deep clean the kitchen', 'assignedTo': 'You'},
          {'id': '2', 'time': '02:00 PM', 'title': 'Take out trash', 'description': 'Take out all trash bins', 'assignedTo': 'Roommate 1'},
        ];
        recentNotifications = [
          {'id': '1', 'title': 'New chore assigned', 'time': '1h ago'},
          {'id': '2', 'title': 'Rent due reminder', 'time': '3h ago'},
        ];
        boundaries = [
          {'id': '1', 'name': 'Quiet Hours', 'status': 'Active'},
          {'id': '2', 'name': 'Guest Policy', 'status': 'Needs Review'},
        ];
      });
    } catch (e) {
      // TODO: Handle error (show error message)
      print('Error fetching dashboard data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load dashboard data. Please try again.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _navigateToBoundaryEdit(Map<String, dynamic>? boundary) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BoundaryEditScreen(boundary: boundary),
      ),
    ).then((_) => _fetchDashboardData());
  }

  void _navigateToTaskDetail(Map<String, dynamic> task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    ).then((_) => _fetchDashboardData());
  }

  void _navigateToTaskEdit(Map<String, dynamic>? task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: task),
      ),
    ).then((_) => _fetchDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${context.watch<UserProvider>().username}'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications screen
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchDashboardData,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildTodaySchedule(),
                  SizedBox(height: 20),
                  _buildRecentNotifications(),
                  SizedBox(height: 20),
                  _buildBoundariesSummary(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTaskEdit(null),
        child: Icon(Icons.add),
        tooltip: 'Add new task',
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Roommates'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0, // Since we're on the home screen
        onTap: (index) {
          // TODO: Implement navigation to other screens
        },
      ),
    );
  }

  Widget _buildTodaySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Schedule', style: Theme.of(context).textTheme.headline6),
        SizedBox(height: 10),
        ...todaySchedule.map((task) => ListTile(
          leading: Icon(Icons.access_time),
          title: Text(task['title']),
          subtitle: Text('${task['time']} - ${task['assignedTo']}'),
          onTap: () => _navigateToTaskDetail(task),
        )).toList(),
      ],
    );
  }

  Widget _buildRecentNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Notifications', style: Theme.of(context).textTheme.headline6),
        SizedBox(height: 10),
        ...recentNotifications.map((notification) => ListTile(
          leading: Icon(Icons.notifications),
          title: Text(notification['title']),
          subtitle: Text(notification['time']),
          onTap: () {
            // TODO: Navigate to notification detail or relevant screen
          },
        )).toList(),
      ],
    );
  }

  Widget _buildBoundariesSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Boundaries Summary', style: Theme.of(context).textTheme.headline6),
        SizedBox(height: 10),
        ...boundaries.map((boundary) => ListTile(
          leading: Icon(Icons.security),
          title: Text(boundary['name']),
          trailing: Chip(
            label: Text(boundary['status']),
            backgroundColor: boundary['status'] == 'Active' ? Colors.green : Colors.orange,
          ),
          onTap: () => _navigateToBoundaryEdit(boundary),
        )).toList(),
      ],
    );
  }
}