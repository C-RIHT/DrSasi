import 'dart:math';
import 'package:flutter/material.dart';

class Patient {
  final String name;
  final int age;
  final String sex;
  final String diagnosis;
  final int fundusScore;
  final DateTime procedureDate;
  final String vfqStatus;
  final DateTime? vfqDate;
  final String lowLuminenceStatus;
  final DateTime? lowLuminenceDate;
  final String pinNo;

  Patient({
    required this.name,
    required this.age,
    required this.sex,
    required this.diagnosis,
    required this.fundusScore,
    required this.procedureDate,
    required this.vfqStatus,
    this.vfqDate,
    required this.lowLuminenceStatus,
    this.lowLuminenceDate,
    this.pinNo = '',
  });

  factory Patient.createRandom() {
    final random = Random();
    final letters = 'abcdefghijklmnopqrstuvwxyz';
    final pinNo = _generateRandomPinNo(random, letters);
    return Patient(
      name: 'New Patient',
      age: random.nextInt(100),
      sex: random.nextBool() ? 'Male' : 'Female',
      diagnosis: 'Random Diagnosis',
      fundusScore: random.nextInt(10),
      procedureDate: DateTime.now(),
      vfqStatus: 'Not Completed',
      lowLuminenceStatus: 'Not Completed',
      pinNo: pinNo,
    );
  }

  static String _generateRandomPinNo(Random random, String letters) {
    return List.generate(6, (_) => letters[random.nextInt(letters.length)])
            .join() +
        List.generate(3, (_) => random.nextInt(10).toString()).join();
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Patient> patients = [
    Patient(
      name: 'John Doe',
      age: 45,
      sex: 'Male',
      diagnosis: 'Glaucoma',
      fundusScore: 3,
      procedureDate: DateTime(2023, 4, 15),
      vfqStatus: 'Completed',
      vfqDate: DateTime(2023, 4, 10),
      lowLuminenceStatus: 'Completed',
      lowLuminenceDate: DateTime(2023, 4, 12),
      pinNo:
          Patient._generateRandomPinNo(Random(), 'abcdefghijklmnopqrstuvwxyz'),
    ),
    Patient(
      name: 'Jane Smith',
      age: 32,
      sex: 'Female',
      diagnosis: 'Cataract',
      fundusScore: 2,
      procedureDate: DateTime(2023, 3, 20),
      vfqStatus: 'Not Completed',
      lowLuminenceStatus: 'Completed',
      lowLuminenceDate: DateTime(2023, 3, 18),
      pinNo:
          Patient._generateRandomPinNo(Random(), 'abcdefghijklmnopqrstuvwxyz'),
    ),
  ];

  void _addNewPatient(Patient newPatient) {
    setState(() {
      patients.add(newPatient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${patient.name}'),
                          SizedBox(height: 8),
                          Text('Age: ${patient.age}, Sex: ${patient.sex}'),
                          SizedBox(height: 8),
                          Text('Diagnosis: ${patient.diagnosis}'),
                          SizedBox(height: 8),
                          Text('Fundus Score: ${patient.fundusScore}'),
                          SizedBox(height: 8),
                          Text(
                              'Procedure Date: ${patient.procedureDate.toString().substring(0, 10)}'),
                          SizedBox(height: 8),
                          Text('VFQ Status: ${patient.vfqStatus}'),
                          if (patient.vfqStatus == 'Completed')
                            Text(
                                'VFQ Date: ${patient.vfqDate?.toString().substring(0, 10) ?? ''}'),
                          SizedBox(height: 8),
                          Text(
                              'Low Luminence Status: ${patient.lowLuminenceStatus}'),
                          if (patient.lowLuminenceStatus == 'Completed')
                            Text(
                                'Low Luminence Date: ${patient.lowLuminenceDate?.toString().substring(0, 10) ?? ''}'),
                          SizedBox(height: 8),
                          Text('PIN No: ${patient.pinNo}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddPatientPage(onSavePatient: _addNewPatient)),
                );
              },
              child: Text('Add New Patient'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPatientPage extends StatefulWidget {
  final void Function(Patient) onSavePatient;

  AddPatientPage({required this.onSavePatient});

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sexController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _fundusScoreController = TextEditingController();
  final _procedureDateController = TextEditingController();

  void _saveNewPatient() {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    final sex = _sexController.text.trim();
    final diagnosis = _diagnosisController.text.trim();
    final fundusScore = int.tryParse(_fundusScoreController.text.trim()) ?? 0;
    final procedureDate =
        DateTime.tryParse(_procedureDateController.text.trim()) ??
            DateTime.now();
    final pinNo = _generateRandomPinNo();

    final newPatient = Patient(
      name: name,
      age: age,
      sex: sex,
      diagnosis: diagnosis,
      fundusScore: fundusScore,
      procedureDate: procedureDate,
      vfqStatus: 'Not Completed',
      lowLuminenceStatus: 'Not Completed',
      pinNo: pinNo,
    );

    widget.onSavePatient(newPatient);
    Navigator.pop(context);
  }

  String _generateRandomPinNo() {
    final random = Random();
    final letters = 'abcdefghijklmnopqrstuvwxyz';
    final pinNo =
        List.generate(6, (_) => letters[random.nextInt(letters.length)])
                .join() +
            List.generate(3, (_) => random.nextInt(10).toString()).join();
    return pinNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Patient'),
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
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _sexController,
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _diagnosisController,
              decoration: InputDecoration(labelText: 'Diagnosis'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _fundusScoreController,
              decoration: InputDecoration(labelText: 'Fundus Score'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _procedureDateController,
              decoration: InputDecoration(labelText: 'Procedure Date'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveNewPatient,
              child: Text('Save Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
