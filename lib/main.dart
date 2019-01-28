import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  // final _listdata = ["1","2","3","4","5","1","2","3","4","5","1","2","3","4","5","1","2","3","4","5","1","2","3","4","5"];
  
  // 创建一个给native的channel
  static const platform = const MethodChannel('my.yy.com/my_flutter');


  final _listdata = List.generate(1000, (int i) => i.toString());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('收藏列表'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
        leading: new IconButton(icon: const Icon(Icons.arrow_back), onPressed: _pushExit),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 0),
        itemBuilder: (BuildContext _context, int i) {
          if (i < _listdata.length){
            return new ListTile(
              title: new Text(_listdata[i]),
            );
          }
          // if (i.isOdd) {
          //   return const Divider();
          // }
          // final int index = i ~/ 2;
          // if (index >= _suggestions.length) {
          //   _suggestions.addAll(generateWordPairs().take(10));
          // }
          // return _buildRow(_suggestions[index]);

        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  
  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text("Alert"),
            content: new Text("My alert message"),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true, child: new Text("Close")),
              CupertinoDialogAction
              (onPressed: _pushSaved, child: new Icon(Icons.favorite))
            ],
          ),
    );
  }

  void _pushExit() async{
    // displayDialog();
    launch('https://flutter.io');
    // try {
    //   await platform.invokeMethod('toNativePop');
    // } on PlatformException catch (e) {
    //   print( "Failed to get battery level: '${e.message}'.");
    // }
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: 
              new ListView(children: divided),
              // new Center(
              //   child: FlatButton(
              //     child: Text('POP'),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
          );
        },
      ),
    );
  }
}