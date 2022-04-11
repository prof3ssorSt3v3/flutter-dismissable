import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = List<String>.generate(25, (int index) {
    WordPair wp = WordPair.random(top: 100);
    return '${wp.first} ${wp.second}';
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismissable'),
      ),
      body: ListView.builder(
        itemBuilder: _buildDismiss, //instead of _buildList
        itemCount: items.length,
      ),
    );
  }

  Widget _buildList(BuildContext context, int index) {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text(items[index]),
      trailing: Icon(Icons.water),
    );
  }

  Widget _buildDismiss(BuildContext context, int index) {
    return Dismissible(
      key: ValueKey<String>(items[index]),
      child: ListTile(
        leading: Icon(Icons.account_circle),
        title: Text(items[index]),
        trailing: Icon(Icons.water),
      ),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Padding(
          child: Icon(Icons.cancel),
          padding: EdgeInsets.all(8.0),
        ),
      ),
      confirmDismiss: (DismissDirection dir) async {
        //confirm the deletion return is Future<bool>
        // return Future(() => true);
        return await showDialog<Future<bool>>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Delete Confirmation'),
            content:
                const Text('Are you sure that you want to delete this item?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, Future(() => false)),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, Future(() => true));
                },
                child: const Text('Kill it with Fire'),
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: ((DismissDirection dir) {
        //user has swiped far enough
        //update the state list of items
        setState(() {
          items.removeAt(index);
        });
        //removes the ListTile widget by triggering build()
      }),
    );
  }
}
