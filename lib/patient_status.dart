import 'package:flutter/material.dart';
import 'package:my_clinical_app/question_page.dart'; // Replace with your actual file path

class PatientStatus extends StatelessWidget {
  final String pinNO;
  const PatientStatus({required this.pinNO});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wireframe Layout',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber,
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
            .copyWith(secondary: Colors.amber),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Status'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              DetailBox(label: 'Name', value: "Test1"),
              SizedBox(height: 8.0),
              DetailBox(label: 'Pin No', value: pinNO),
              SizedBox(height: 16.0),
              TestBox(title: 'VFQ', pinNO: pinNO),
              SizedBox(height: 8.0),
              TestBox(title: 'Low Luminence', pinNO: pinNO),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailBox extends StatelessWidget {
  final String label;
  final String value;

  DetailBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
          Text(value, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

class TestBox extends StatefulWidget {
  final String title;
  final String pinNO;

  TestBox({required this.title, required this.pinNO});

  @override
  _TestBoxState createState() => _TestBoxState();
}

class _TestBoxState extends State<TestBox> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // VFQ box
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[100]!,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VFQ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'VFQ Value',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          _isCompleted ? Colors.green : Colors.blueGrey[500],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    onPressed: () {
                      // Show language selection dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select Language'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to QuestionPage with 'English' language
                                    Navigator.pop(context, 'English');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuestionPage(
                                          language: 'English',
                                          pinNO: widget.pinNO,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('English'),
                                ),
                                SizedBox(
                                    height:
                                        16.0), // Add space between the buttons
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to QuestionPage with 'Tamil' language
                                    Navigator.pop(context, 'Tamil');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuestionPage(
                                          language: 'Tamil',
                                          pinNO: widget.pinNO,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Tamil'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Select'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.0), // Add space between the boxes
          // LOWLUMINENCE box
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[100]!,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOWLUMINENCE',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Low Luminence Value',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          _isCompleted ? Colors.green : Colors.blueGrey[500],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    onPressed: () {
                      // Show language selection dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select Language'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to QuestionPage with 'English' language
                                    Navigator.pop(context, 'English');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuestionPage(
                                          language: 'English',
                                          pinNO: widget.pinNO,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('English'),
                                ),
                                SizedBox(
                                    height:
                                        16.0), // Add space between the buttons
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to QuestionPage with 'Tamil' language
                                    Navigator.pop(context, 'Tamil');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuestionPage(
                                          language: 'Tamil',
                                          pinNO: widget.pinNO,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Tamil'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Select'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
