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
    WordPair wp = WordPair.random(top: 500);
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
      trailing: Icon(Icons.airline_seat_individual_suite),
    );
  }

  Widget _buildDismiss(BuildContext context, int index) {
    return Dismissible(
      key: ValueKey<String>(items[index]),
      child: _buildList(context, index), //ListTile

      background: Container(
        alignment: Alignment.centerRight, //keep the icon to the right
        color: Colors.red,
        child: Padding(
          child: Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8.0),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection dir) async {
        //confirm the deletion return is Future<bool>
        // return Future(() => false);
        //we need to return the boolean that is wrapped inside a Future
        //need to resolve the Future to get to the boolean
        // use the await to get to the boolean
        return await showDialog<Future<bool>>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Delete Confirmation',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            content: const Text(
                'Are you sure that you want to delete this item?',
                style: TextStyle(color: Colors.black87)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  //remove the AlertDialog from the screen
                  //return the Future containing the true boolean
                  Navigator.pop(context, Future(() => false));
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //remove the AlertDialog from the screen
                  //return the Future containing the true boolean
                  Navigator.pop(context, Future(() => true));
                },
                child: const Text(
                  'Kill it with Fire',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: ((DismissDirection dir) {
        print(dir);
        //user has swiped far enough
        //update the state list of items
        setState(() {
          items.removeAt(index);
          // List.removeAt( position in the list )
          //Call the API first to tell it to delete the data
        });
        //removes the ListTile widget by triggering build()
      }),
    );
  }
}
