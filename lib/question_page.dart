import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Assuming you have a data_models.dart file with the Question and Option classes defined
import 'package:my_clinical_app/data_models.dart';

class QuestionPage extends StatefulWidget {
  final String pinNO;
  final String language;

  const QuestionPage({Key? key, required this.language, required this.pinNO})
      : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _currentQuestionIndex = 0;
  late PageController _pageController;
  late List<Question> _questions = [];
  Map<int, int> _selectedAnswers =
      {}; // Map to store selected answer indices (for efficient scoring)
  int _totalScore = 0; // Track total score throughout the quiz
  bool _isLastQuestion =
      false; // Add this line to define the _isLastQuestion variable

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadQuestions(widget.language);
  }

  Future<void> _loadQuestions(String language) async {
    String jsonFileName = language == 'English'
        ? 'English_Low_Luminence.json'
        : 'Tamil_Low_Luminence.json';
    String jsonString =
        await rootBundle.loadString('assets/data/$jsonFileName');
    final jsonResponse = json.decode(jsonString) as List;
    setState(() {
      _questions = jsonResponse.map((q) => Question.fromJson(q)).toList();
    });
  }

  void _handleNext() {
    if (_currentQuestionIndex < _questions.length - 1) {
      // Update score if an answer is selected
      if (_selectedAnswers.containsKey(_currentQuestionIndex)) {
        int? selectedScore = _questions[_currentQuestionIndex]
            .options[_selectedAnswers[_currentQuestionIndex]!]
            .score;
        if (selectedScore != null) {
          _totalScore += selectedScore;
        }
      }
      _pageController.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else {
      // Handle reaching the last question
      _isLastQuestion = true;
      _showFinalScoreDialog();
    }
  }

  void _handlePrevious() {
    if (_currentQuestionIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void _showFinalScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Final Score'),
        content: Text('Your total score is: $_totalScore'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions for Pin No: ${widget.pinNO}'),
      ),
      body: (_questions.isNotEmpty)
          ? PageView.builder(
              controller: _pageController,
              onPageChanged: (index) =>
                  setState(() => _currentQuestionIndex = index),
              itemCount: _questions.length,
              itemBuilder: (context, index) =>
                  _buildQuestion(_questions[index]),
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (_currentQuestionIndex > 0)
            FloatingActionButton(
              onPressed: _handlePrevious,
              child: Icon(Icons.arrow_back),
            ),
          if (!_isLastQuestion)
            FloatingActionButton(
              onPressed: _handleNext,
              child: Icon(Icons.arrow_forward),
            ),
          if (_isLastQuestion)
            FloatingActionButton(
              onPressed: _showFinalScoreDialog,
              child: Icon(Icons.check),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestion(Question question) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question.text,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true, // Prevent list view from expanding
            itemCount: question.options.length,
            itemBuilder: (context, optionIndex) {
              final Option option = question.options[optionIndex];
              return RadioListTile<int>(
                title: Text(option.answer),
                value:
                    optionIndex, // Store the option index for efficient scoring
                groupValue: _selectedAnswers[
                    _currentQuestionIndex], // Set the selected group based on current question index
                onChanged: (value) {
                  setState(() {
                    _selectedAnswers[_currentQuestionIndex] =
                        value!; // Update selected answer index
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
