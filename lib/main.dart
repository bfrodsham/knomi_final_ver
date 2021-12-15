import 'package:flutter/material.dart';

void main() => runApp(const KnomiApp());

class KnomiApp extends StatelessWidget {
  const KnomiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knomi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      bottomNavigationBar: const _BottomAppBar(),
    );
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
  const _BottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.centerDocked,
  });
  final FloatingActionButtonLocation fabLocation;

  static final centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
  ];

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
            if (centerLocations.contains(fabLocation)) const Spacer(),
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
