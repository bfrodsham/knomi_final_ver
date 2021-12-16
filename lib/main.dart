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
          secondary: Colors.deepOrange,
        ),
      ),
    );
  }
}

class MyEntries extends StatefulWidget {
  const MyEntries({Key? key}) : super(key: key);

  @override
  _MyEntriesState createState() => _MyEntriesState();
}

class _MyEntriesState extends State<MyEntries> with TickerProviderStateMixin {
  List<Entry> _entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Knomi - My Entries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: _entries.length != 0
                ? ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, index) => _entries[index],
                    itemCount: _entries.length,
                    key: UniqueKey(),
                  )
                : const Center(
                    child: Text(
                        'You haven\'t written any entries yet. \n Tap the book icon below to get started!',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        )),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_createEntry()},
        tooltip: 'Create',
        child: const Icon(
          Icons.book_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _createEntry() async {
    SurveyResult result =
        (await Navigator.pushNamed(context, '/survey') as SurveyResult);

    if (result.finishReason == FinishReason.COMPLETED) {
      Entry surveyEntry = Entry(
          moodLevel: result.results[1].results[0].result,
          hoursSlept: result.results[2].results[0].result,
          activityTags: result.results[3].results[0].result,
          foodTags: result.results[4].results[0].result,
          note: result.results[5].results[0].result,
          animationController: AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: this,
          ));
      setState(() {
        _entries.insert(0, surveyEntry);
      });
    }
  }
}

class Entry extends StatelessWidget {
  const Entry({
    required this.moodLevel,
    required this.hoursSlept,
    required this.activityTags,
    required this.foodTags,
    required this.note,
    required this.animationController,
    Key? key,
  }) : super(key: key);
  final double moodLevel;
  final int hoursSlept;
  final List activityTags;
  final List foodTags;
  final String note;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Container(
                child: Text(
                    'Mood Level: ' + moodLevel.toString(),
                    style: const TextStyle( color: Colors.black, backgroundColor: Colors.white)
                ),
            ),
            Container(
                child: Text('Hours of Sleep: ' + hoursSlept.toString())),
            Container(
                child: Column(children: [
                  Row(children: const [Text('Activities: ')]),
                  for (TextChoice activity in activityTags)
                    Row(children: [Text(activity.text)])
                ])),
            Container(
                child: Column(children: [
                  Row(children: const [Text('Dietary Foods: ')]),
                  for (TextChoice food in foodTags)
                    Row(children: [Text(food.text)])
                ])),
            Container(
                child: Text('Note: ' + note)),
          ],
        ),
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.cyan,
      shape: null,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              tooltip: 'View Insights',
              color: Colors.white,
              icon: const Icon(Icons.lightbulb),
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Settings',
              color: Colors.white,
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
              onResult: (SurveyResult result) {
                Navigator.pop(context, result);
              },
              task: task)),
    );
  }

  var task = NavigableTask(id: TaskIdentifier(), steps: [
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
        )),
    QuestionStep(
      title: 'In total, how much have you \nslept so far today?',
      text: '(This will be added to any sleep you\'ve already submitted today)',
      answerFormat: const IntegerAnswerFormat(
        defaultValue: 0,
        hint: 'Please enter your hours of sleep here.',
      ),
    ),
    QuestionStep(
      title: 'Your Activities',
      text:
          'Of the general listed activities, which have you done today so far?',
      answerFormat: const MultipleChoiceAnswerFormat(textChoices: [
        TextChoice(text: 'Basic Self-care', value: 'Basic Self-care'),
        TextChoice(text: 'Exercise', value: 'Exercise'),
        TextChoice(text: 'Productive Pursuits', value: 'Productive Pursuits'),
        TextChoice(
            text: 'Practicing Hobby/Skill', value: 'Practicing Hobby/Skill'),
        TextChoice(
            text: 'Recreation or Relaxation',
            value: 'Recreation or Relaxation'),
        TextChoice(text: 'Socializing', value: 'Socializing'),
      ]),
    ),
    QuestionStep(
      title: 'Your Diet',
      text: 'Which of these basic food groups have you eaten?',
      answerFormat: const MultipleChoiceAnswerFormat(textChoices: [
        TextChoice(text: 'Fruits', value: 'Fruits'),
        TextChoice(text: 'Vegetables', value: 'Vegetables'),
        TextChoice(text: 'Dairy Products', value: 'Dairy Products'),
        TextChoice(text: 'Sources of Protein', value: 'Sources of Protein'),
        TextChoice(text: 'Sources of Grain', value: 'Sources of Grain'),
        TextChoice(
            text: 'Sweets, Treats, Snacks', value: 'Sweets, Treats, Snacks'),
      ]),
    ),
    QuestionStep(
      title: 'Note',
      text:
          'Anything else you\'d like to note about this entry? If not, you can leave this section blank.',
      answerFormat: const TextAnswerFormat(
        maxLines: 8,
        validationRegEx: "",
      ),
    ),
    CompletionStep(
        stepIdentifier: StepIdentifier(id: DateTime.now().toString()),
        title: 'All done',
        text: 'Good job! You\'re learning more about yourself with each entry.')
  ]);
}
