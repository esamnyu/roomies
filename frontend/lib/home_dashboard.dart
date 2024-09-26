import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'auth/user_provider.dart';
import 'boundary_edit_screen.dart';
import 'task_detail_screen.dart';
import 'task_edit_screen.dart';
import 'notification_screen.dart';
import 'roommate_list_screen.dart';
import 'boundary_setting_screen.dart';
import 'task_list_screen.dart';

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
    // TODO: Implement socket initialization
    socket = IO.io('SERVER_URL', <String, dynamic>{
      'transports': ['websocket'],
    });
  }

  void _navigateToBoundarySetting() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BoundarySettingScreen()),
    ).then((_) => _fetchDashboardData());
  }

  void _navigateToTasks() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskListScreen()),
    ).then((_) => _fetchDashboardData());
  }

  void _navigateToSettings() {
    // TODO: Implement SettingsScreen and uncomment the following lines
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SettingsScreen()),
    // ).then((_) => _fetchDashboardData());
    print("Settings screen not implemented yet");
  }

  Future<void> _fetchDashboardData() async {
    // TODO: Implement actual data fetching
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    setState(() {
      todaySchedule = [
        {'id': '1', 'time': '09:00 AM', 'title': 'Clean Kitchen', 'assignedTo': 'You'},
        {'id': '2', 'time': '02:00 PM', 'title': 'Take out trash', 'assignedTo': 'Roommate 1'},
      ];
      recentNotifications = [
        {'id': '1', 'title': 'New chore assigned', 'time': '1h ago'},
        {'id': '2', 'title': 'Rent due reminder', 'time': '3h ago'},
      ];
      boundaries = [
        {'id': '1', 'name': 'Quiet Hours', 'status': 'Active'},
        {'id': '2', 'name': 'Guest Policy', 'status': 'Needs Review'},
      ];
      isLoading = false;
    });
  }

  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    ).then((_) => _fetchDashboardData());
  }

  void _navigateToTaskEdit(Map<String, dynamic>? task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskEditScreen(task: task)),
    ).then((_) => _fetchDashboardData());
  }

  void _navigateToRoommates() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoommateListScreen()),
    ).then((_) => _fetchDashboardData());
  }

  Widget _buildTodaySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Schedule', style: Theme.of(context).textTheme.titleLarge),
        ...todaySchedule.map((task) => ListTile(
          title: Text(task['title']),
          subtitle: Text('${task['time']} - ${task['assignedTo']}'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildRecentNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Notifications', style: Theme.of(context).textTheme.titleLarge),
        ...recentNotifications.map((notification) => ListTile(
          title: Text(notification['title']),
          subtitle: Text(notification['time']),
          onTap: _navigateToNotifications,
        )).toList(),
      ],
    );
  }

  Widget _buildBoundariesSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Boundaries Summary', style: Theme.of(context).textTheme.titleLarge),
        ...boundaries.map((boundary) => ListTile(
          title: Text(boundary['name']),
          trailing: Chip(
            label: Text(boundary['status']),
            backgroundColor: boundary['status'] == 'Active' ? Colors.green : Colors.orange,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoundaryEditScreen(boundary: boundary)),
          ),
        )).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${context.watch<UserProvider>().username}'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _navigateToNotifications,
          ),
        ],  
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTaskEdit(null),
        child: Icon(Icons.add),
        tooltip: 'Add new task',
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return RefreshIndicator(
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
    );
  }
}