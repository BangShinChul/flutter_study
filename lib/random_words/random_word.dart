import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // Dart 언어에서는 식별자 앞에 밑줄을 붙이면 프라이빗 적용이 됩니다.
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>(); 
  final _biggerFont = const TextStyle(fontSize: 18.0);
  
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  /*
  _buildSuggestions() 함수는 단어 쌍 마다 한 번 씩 _buildRow()를 호출합니다. 이 함수는 ListTile에서 각각 새로운 쌍을 표시하여 다음 단계에서 행을 더 매력적으로 만들 수 있게 합니다.
  */
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) { // i는 index입니다. itemBuilder 콜백은 단어 쌍이 제안될 때마다 호출되고 각각을 ListTile 행에 배치합니다. index가 짝수 행인 경우 ListTile 행에 단어 쌍을 추가합니다. 홀수 행인 경우 시각적으로 각 항목을 구분하는 Divider 위젯을 추가합니다. 작은 기기에서는 구분선을 보기 어려울 수 있습니다.
        if (i.isOdd) return Divider(); /*2*/ // ListView의 각 행 앞에 1 픽셀 높이의 구분선 위젯을 추가하십시오. isOdd는 정수가 홀수인 경우에만 true를 리턴합니다.

        final index = i ~/ 2; /*3*/ // i ~/ 2 표현식은 i를 2로 나눈 뒤 정수 결과를 반환합니다. 예를 들어: 1, 2, 3, 4, 5는 0, 1, 1, 2, 2가 됩니다. 이렇게 하면 구분선 위젯을 제외한 ListView에 있는 단어 쌍 수가 계산됩니다.
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/ // 가능한 단어 쌍을 모두 사용하고 나면, 10개를 더 생성하고 제안 목록에 추가합니다.
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {

    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
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
}