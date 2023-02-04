import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const detailsPageRouteName = '/details';

class YerApp extends StatelessWidget {
  const YerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        detailsPageRouteName: (context) => const DetailsPage(),
      },
    );
  }
}

@immutable
class Person {
  final String name;
  const Person({
    required this.name,
  });
}

class PersonView extends StatelessWidget {
  final Person person;
  const PersonView({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [Text("Name : "), Text(person.name)],
        ),
      ],
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: Column(
        children: [
          Text("text"),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final mockPersons = Iterable.generate(
  100,
  (index) => Person(
    name: 'Person #${index + 1}',
  ),
);

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: mockPersons.map((e) => PersonView(person: e)).toList(),
        ),
      )),
    );
  }
}
