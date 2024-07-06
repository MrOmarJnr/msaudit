import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:msaudit/user_model.dart';
import 'package:msaudit/completescreen.dart';
import 'package:geolocator/geolocator.dart';

class ProcessingScreen extends StatefulWidget {
  final Tasklist user;

  const ProcessingScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProcessingScreenState createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _submitData() {
    // Add logic to send information to the database
  }

  void _completeTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompleteScreen(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processing Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Additional Information',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notes',
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Checklist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildQuestionnaire(),
            SizedBox(height: 32),
            Text(
              'Take Pictures',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 16),
            _buildImageGrid(),
            SizedBox(height: 32),
            if (_currentPosition != null) ...[
              Text(
                'Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Lat: ${_currentPosition!.latitude}, Long: ${_currentPosition!.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
            ],
            Center(
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit'),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _completeTask,
                child: Text('Complete'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionnaire() {
    return Column(
      children: [
        _buildQuestion('Question 1'),
        _buildQuestion('Question 2'),
        _buildQuestion('Question 3'),
      ],
    );
  }

  Widget _buildQuestion(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyle(fontSize: 16)),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('Pass'),
                leading: Radio(
                  value: 'pass',
                  groupValue: null,
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Fail'),
                leading: Radio(
                  value: 'fail',
                  groupValue: null,
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return Image.file(_images[index], fit: BoxFit.cover);
      },
    );
  }
}
