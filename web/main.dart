// ignore: depend_on_referenced_packages
import 'package:web/web.dart';
import 'package:word_collection_utils/src/utils/word_collection_utils.dart';

Future<void> main() async {
  final randomWordElement =
      document.querySelector('#randomWord') as HTMLDivElement;
  final wordIndexElement =
      document.querySelector('#wordIndex') as HTMLDivElement;
  final wordRangeElement =
      document.querySelector('#wordRange') as HTMLDivElement;
  final wordUtils = WordCollectionUtils(collectionPath: 'collection.csv');

  final randomWord = await wordUtils.getRandomWord();
  randomWordElement.appendChild(
    document.createTextNode('Random word: ${randomWord.value}\n'),
  );

  final word0 = await wordUtils.getWord(0);
  wordIndexElement.appendChild(
    document.createTextNode('Word at index 0: ${word0.value}\n'),
  );

  final words = await wordUtils.getWordsByRangeIndex(0, 2);
  wordRangeElement.appendChild(
    document.createTextNode(
      'Words 0-2: ${words.map((w) => w.value).join(', ')}\n',
    ),
  );
}
