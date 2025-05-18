import 'dart:math';

import 'package:word_collection_utils/src/io/word_collection_io.dart';
import 'package:word_collection_utils/src/models/file_contents.dart';
import 'package:word_collection_utils/src/models/options.dart';

import '../models/word.dart';

class WordCollectionUtils {
  final String collectionPath;
  final Options? options;
  WordCollectionIo wordCollectionIo = WordCollectionIo();

  WordCollectionUtils({
    required this.collectionPath,
    this.options = const Options(),
  }) {
    init();
  }

  void init() {
    bool initResult = wordCollectionIo.init(
      collectionPath: collectionPath,
      metadataPath: options?.metadataPath,
      saveToMemory: options?.saveToMemory ?? false,
      hasHeaders: options?.hasHeaders ?? true,
    );

    if (!initResult) {
      throw Exception(
        'Failed to initialize WordCollectionUtils. Please check the collection path.',
      );
    }
  }

  Future<Word> getWord(int index) async {
    FileContents wordCollection = await wordCollectionIo.getWordCollection();
    if (index < 0 || index >= wordCollection.lines.length) {
      throw RangeError('Index out of range: $index');
    }
    return getWordByLine(wordCollection.lines[index]);
  }

  Future<Word> getRandomWord() async {
    FileContents wordCollection = await wordCollectionIo.getWordCollection();
    int randomIndex = Random().nextInt(wordCollection.lines.length);
    return getWordByLine(wordCollection.lines[randomIndex]);
  }

  Future<List<Word>> getWordsByRangeIndex(int start, int end) async {
    FileContents wordCollection = await wordCollectionIo.getWordCollection();
    if (start < 0 || end >= wordCollection.lines.length || start > end) {
      throw RangeError('Index out of range: $start to $end');
    }
    return wordCollection.lines
        .sublist(start, end + 1) // Get the sublist of lines from start to end
        .map(
          (word) => getWordByLine(word),
        ) // Convert each line to a Word object
        .toList(); // Return a list of Word objects
  }

  Word getWordByLine(String line) {
    final lineParts = line.split(',');
    return Word(value: lineParts[0], index: int.parse(lineParts[1]));
  }
}
