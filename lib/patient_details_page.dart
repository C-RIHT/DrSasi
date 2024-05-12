import 'package:flutter/material.dart';

import 'package:my_clinical_app/patient_status.dart';
// Replace with your actual file path

class PatientDetailsPage extends StatefulWidget {
  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedSex = 'Male'; // Default selected sex option

  void _handleNext() {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim());

    if (name.isEmpty) {
      // ... your validation logic ...
    } else if (age == null || age <= 0) {
      // ... your validation logic ...
    } else {
      // Navigate to the QuestionPage with patient details
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientStatus(
                  pinNO: '',
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedSex,
              items: ['Male', 'Female', 'Other']
                  .map((sex) => DropdownMenuItem(
                        value: sex,
                        child: Text(sex),
                      ))
                  .toList(),
              onChanged: (value) =>
                  setState(() => _selectedSex = value as String),
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleNext,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
