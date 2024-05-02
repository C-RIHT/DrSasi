import 'package:flutter/material.dart';
import 'package:my_clinical_app/investigator_request_form.dart';
import 'package:my_clinical_app/patient_details_page.dart';
import 'package:my_clinical_app/dashboard_page.dart';
import 'package:my_clinical_app/patient_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Clinical App',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _patientPinController = TextEditingController();
  final _investigatorPinController = TextEditingController();

  bool _verifyPatientPin(String pin) {
    // Replace with your actual patient PIN verification logic
    return pin == "1234"; // Example PIN for verification
  }

  bool _verifyInvestigatorPin(String pin) {
    // Replace with your actual investigator PIN verification logic
    return pin == "5678"; // Example PIN for verification
  }

  void _handlePatientVerification() {
    final pin = _patientPinController.text.trim();

    if (_verifyPatientPin(pin)) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientStatus(
                  pinNO: pin,
                )),
      );
    } else {
      _showPatientPinFailedDialog();
    }
  }

  void _showPatientPinFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification Failed'),
          content: Text('Please speak with the doctor for further assistance.'),
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

  void _showInvestigatorPinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Investigator PIN'),
          content: TextField(
            controller: _investigatorPinController,
            decoration: InputDecoration(
              hintText: 'Enter Investigator PIN',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final investigatorPin = _investigatorPinController.text.trim();
                if (_verifyInvestigatorPin(investigatorPin)) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Verification Failed'),
                        content: Text('Create Investigator Profile'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InvestigatorRequestForm()),
                              );
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit'),
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
        title: Text('PIN Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _patientPinController,
              decoration: InputDecoration(labelText: 'Enter Patient PIN'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handlePatientVerification,
              child: Text('Verify Patient PIN'),
            ),
            Spacer(),
            GestureDetector(
              onTap: _showInvestigatorPinDialog,
              child: Text(
                'I am an Investigator',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
