import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

void main() => runApp(const KnomiApp());

class KnomiApp extends StatelessWidget {
  const KnomiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knomi',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyEntries(),
        '/survey': (context) => const KnomiSurvey(),
      },
      theme: ThemeData(

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
        ).copyWith(
          secondary: Colors.deepOrangeAccent,
        ),
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
      ),
      home: const MyEntries(),
    );
  }
}

class MyEntries extends StatefulWidget {
  const MyEntries({Key? key}) : super(key: key);

  @override
  _MyEntriesState createState() => _MyEntriesState();
}

class _MyEntriesState extends State<MyEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Entries'),
      ),
      bottomNavigationBar: _BottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _startEntry,
        tooltip: 'Create',
        child: const Icon(Icons.book_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _startEntry() {
    Navigator.pushNamed(context, '/survey');
  }
}

class Entry extends StatelessWidget {
  const Entry({
    required this.moodLevel,
    required this.hoursSlept,
    required this.activityTags,
    required this.foodTags,
    Key? key,
  }) : super(key: key);
  final int moodLevel;
  final double hoursSlept;
  final List activityTags;
  final List foodTags;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _BottomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: null,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              tooltip: 'View Insights',
              icon: const Icon(Icons.lightbulb),
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Go to Settings',
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class KnomiSurvey extends StatefulWidget {
  const KnomiSurvey({Key? key}) : super(key: key);

  @override
  _KnomiSurveyState createState() => _KnomiSurveyState();
}

class _KnomiSurveyState extends State<KnomiSurvey> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SurveyKit(
          onResult: (SurveyResult ) {
            // Evaluate results
          },
          task: task
        )
      ),
    );
  }

  var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Let\'s catch up!',
          text: 'Answer all of the questions that apply.',
          buttonText: 'Ready',
        ),
        QuestionStep(
            title: 'How are you doing?',
            answerFormat: const ScaleAnswerFormat(
              step: 1,
              minimumValue: 1,
              maximumValue: 5,
              defaultValue: 3,
              minimumValueDescription: 'Awful',
              maximumValueDescription: 'Great',
            )
        ),
        QuestionStep(
          title: 'Your Sleep',
          text: 'How many hours of quality sleep have you had since you went to bed yesterday?',
          answerFormat: const IntegerAnswerFormat(
            defaultValue: 0,
            hint: 'Please enter your hours of sleep',
          ),
        ),
        QuestionStep(
          title: 'Your Activities',
          text: 'Of the general listed activities, which have you done today so far?',
          answerFormat: const MultipleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Basic Self-care', value: 'Basic Self-care'),
                TextChoice(text: 'Productive Persuits', value: 'Productive Persuits'),
                TextChoice(text: 'Practicing Hobby/Skill', value: 'Practicing Hobby/Skill'),
                TextChoice(text: 'Recreation or Relaxation', value: 'Recreation or Relaxation'),
                TextChoice(text: 'Socializing', value: 'Socializing'),
              ]
          ),
        ),
        QuestionStep(
          title: 'Your Diet',
          text: 'Which of these basic food groups have you eaten?',
          answerFormat: const MultipleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Fruits', value: 'Fruits'),
                TextChoice(text: 'Vegetables', value: 'Vegetables'),
                TextChoice(text: 'Sources of Protein', value: 'Sources of Protein'),
                TextChoice(text: 'Sources of Grain', value: 'Sources of Grain'),
                TextChoice(text: 'Sweets, Treats, Snacks', value: 'Sweets, Treats, Snacks'),
              ]
          ),
        ),
        QuestionStep(
          title: 'Note',
          text: 'Anything else you\'d like to note about this entry?',
          answerFormat: const TextAnswerFormat(
              maxLines: 8
          ),
        ),
        CompletionStep(stepIdentifier: StepIdentifier(id: DateTime.now().toString()),
            title: 'All done',
            text: 'Good job! You\'re learning more about yourself with each entry.')
      ]
  );
}



Future<Task> KnomiEntry() {

  var task = NavigableTask(
    id: TaskIdentifier(),
    steps: [
      InstructionStep(
          title: 'Let\'s catch up!',
          text: 'Answer all of the questions that apply.',
          buttonText: 'Ready',
      ),
      QuestionStep(
          title: 'How are you doing?',
          answerFormat: const ScaleAnswerFormat(
              step: 1,
              minimumValue: 1,
              maximumValue: 5,
              defaultValue: 3,
              minimumValueDescription: 'Awful',
              maximumValueDescription: 'Great',
          )
      ),
      QuestionStep(
        title: 'Your Sleep',
        text: 'How many hours of quality sleep have you had since you went to bed yesterday?',
        answerFormat: const IntegerAnswerFormat(
          defaultValue: 0,
          hint: 'Please enter your hours of sleep',
        ),
      ),
      QuestionStep(
        title: 'Your Activities',
        text: 'Of the general listed activities, which have you done today so far?',
        answerFormat: const MultipleChoiceAnswerFormat(
          textChoices: [
            TextChoice(text: 'Basic Self-care', value: 'Basic Self-care'),
            TextChoice(text: 'Productive Persuits', value: 'Productive Persuits'),
            TextChoice(text: 'Practicing Hobby/Skill', value: 'Practicing Hobby/Skill'),
            TextChoice(text: 'Recreation or Relaxation', value: 'Recreation or Relaxation'),
            TextChoice(text: 'Socializing', value: 'Socializing'),
          ]
        ),
      ),
      QuestionStep(
        title: 'Your Diet',
        text: 'Which of these basic food groups have you eaten?',
        answerFormat: const MultipleChoiceAnswerFormat(
          textChoices: [
            TextChoice(text: 'Fruits', value: 'Fruits'),
            TextChoice(text: 'Vegetables', value: 'Vegetables'),
            TextChoice(text: 'Sources of Protein', value: 'Sources of Protein'),
            TextChoice(text: 'Sources of Grain', value: 'Sources of Grain'),
            TextChoice(text: 'Sweets, Treats, Snacks', value: 'Sweets, Treats, Snacks'),
          ]
        ),
      ),
      QuestionStep(
        title: 'Note',
        text: 'Anything else you\'d like to note about this entry?',
        answerFormat: const TextAnswerFormat(
            maxLines: 8
        ),
      ),
      CompletionStep(stepIdentifier: StepIdentifier(id: DateTime.now().toString()),
          title: 'All done',
          text: 'Good job! You\'re learning more about yourself with each entry.')
    ]
  );
  return Future.value(task);
}
