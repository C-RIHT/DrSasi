class Question {
  final String text;
  final List<Option> options;

  Question.fromJson(Map<String, dynamic> json)
      : text = json['question'] as String,
        options = (json['options'] as List)
            .map((option) => Option.fromJson(option))
            .toList();
}

class Option {
  final String answer;
  final int? score;

  Option({
    required this.answer,
    this.score,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    int? scoreValue;
    if (json['score'] is String) {
      if (json['score'] == 'no score') {
        scoreValue = null;
      } else {
        try {
          scoreValue = int.parse(json['score']);
        } catch (e) {
          scoreValue = null;
        }
      }
    } else if (json['score'] is int) {
      scoreValue = json['score'];
    } else {
      scoreValue = null;
    }

    return Option(
      answer: json['answer'] as String,
      score: scoreValue,
    );
  }
}
