import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const detailsPageRouteName = '/details';

class YerApp extends StatelessWidget {
  const YerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {detailsPageRouteName: (context) => const DetailsPage()},
    );
  }
}

@immutable
class Person {
  final String name;
  final int age;
  const Person({required this.name, required this.age});
}

final mockPerson = Iterable.generate(
    100, (index) => Person(name: "Person #${index + 1}", age: 10 + index));

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Pick a person"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              padding: EdgeInsets.all(16),
              onPressed: () async {
                try {
                  await launchUrl(
                    Uri.parse("https://flutter.dev"),
                  );
                } catch (e) {
                  print("Error launchURL");
                }
              },
              child: const Text("Open"),
            ),
            Text("HEY")
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Person person = ModalRoute.of(context)?.settings.arguments as Person;
    final age = "${person.age} years old";
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(person.name),
            Text(age),
            OutlinedButton.icon(
              icon: Icon(Icons.arrow_back_ios),
              label: Text("Dismiss"),
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 9, 36, 61),
                side: BorderSide(
                  color: Color.fromARGB(255, 238, 196, 31),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
