// landing.dart
import 'package:msaudit/Api_service.dart';
import 'package:flutter/material.dart';
import 'package:msaudit/user_model.dart';
import 'package:msaudit/processingscreen.dart';

class LandingScreen extends StatelessWidget {
  final Tasklist user;

  const LandingScreen({Key? key, required this.user}) : super(key: key);

  void _acceptTicket(BuildContext context) async {
    // Update the status of the ticket to accepted
    //await ApiService.updateTicketStatus(user.id, 'accepted');

    // Navigate to the ProcessingScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProcessingScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Engineer Name',
              ),
              controller: TextEditingController(text: user.field_engineer_name),
              readOnly: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Site Name',
              ),
              controller: TextEditingController(text: user.site_id),
              readOnly: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Task Description',
              ),
              controller: TextEditingController(text: user.task_description),
              readOnly: true,
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => _acceptTicket(context),
                child: Text('Accept'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
