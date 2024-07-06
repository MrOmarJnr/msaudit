import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:msaudit/user_model.dart';
import 'package:msaudit/landing_page.dart';

class CompleteScreen extends StatefulWidget {
  final Tasklist user;

  const CompleteScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CompleteScreenState createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  String? _taskStatus;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _closeTicket() {
    // Add logic to update the ticket status to closed and any other necessary actions
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyBottomNavigationBar()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Done with task?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Yes'),
                    leading: Radio<String>(
                      value: 'yes',
                      groupValue: _taskStatus,
                      onChanged: (value) {
                        setState(() {
                          _taskStatus = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('No'),
                    leading: Radio<String>(
                      value: 'no',
                      groupValue: _taskStatus,
                      onChanged: (value) {
                        setState(() {
                          _taskStatus = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Take a picture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 16),
            if (_image != null) Image.file(_image!, fit: BoxFit.cover),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _closeTicket,
                child: Text('Close Ticket'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
