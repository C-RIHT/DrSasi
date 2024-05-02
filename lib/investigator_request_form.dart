import 'package:flutter/material.dart';

class InvestigatorRequestForm extends StatefulWidget {
  @override
  _InvestigatorRequestFormState createState() =>
      _InvestigatorRequestFormState();
}

class _InvestigatorRequestFormState extends State<InvestigatorRequestForm> {
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _instituteController = TextEditingController();
  final _emailController = TextEditingController();
  final _projectDetailsController = TextEditingController();

  void _handleSubmit() {
    // Process the submitted details
    // Display confirmation message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification Process'),
          content: Text('PIN NO will be communicated by Email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investigator Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _designationController,
              decoration: InputDecoration(labelText: 'Designation'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _instituteController,
              decoration: InputDecoration(labelText: 'Institute Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email ID'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _projectDetailsController,
              decoration: InputDecoration(labelText: 'Project Details'),
              maxLines: 4,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
