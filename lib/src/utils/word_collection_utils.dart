import 'dart:math';

import 'package:word_collection_utils/src/io/word_collection_io.dart';
import 'package:word_collection_utils/src/models/file_contents.dart';
import 'package:word_collection_utils/src/models/options.dart';

import '../models/word.dart';

/// Utility class for interacting with a word collection file,
/// providing methods to retrieve words by index, randomly, or by range.
class WordCollectionUtils {
  /// The file path to the word collection.
  final String collectionPath;

  /// Optional configuration options for handling the word collection.
  final Options? options;

  /// Internal IO utility for reading and managing the word collection.
  WordCollectionIo wordCollectionIo = WordCollectionIo();

  /// Creates a [WordCollectionUtils] instance with the given [collectionPath]
  /// and optional [options].
  ///
  /// Throws an [Exception] if initialization fails.
  WordCollectionUtils({
    required this.collectionPath,
    this.options = const Options(),
  }) {
    init();
  }

  /// Initializes the internal IO utility with the provided options.
  ///
  /// Throws an [Exception] if initialization fails.
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

  /// Retrieves the [Word] at the specified [index] from the collection.
  ///
  /// Throws a [RangeError] if the index is out of bounds.
  Future<Word> getWord(int index) async {
    FileContents wordCollection = await wordCollectionIo.getWordCollection();
    if (index < 0 || index >= wordCollection.lines.length) {
      throw RangeError('Index out of range: $index');
    }
    return getWordByLine(wordCollection.lines[index]);
  }

  /// Retrieves a random [Word] from the collection.
  Future<Word> getRandomWord() async {
    FileContents wordCollection = await wordCollectionIo.getWordCollection();
    int randomIndex = Random().nextInt(wordCollection.lines.length);
    return getWordByLine(wordCollection.lines[randomIndex]);
  }

  /// Retrieves a list of [Word]s from the collection within the specified [start] and [end] indices (inclusive).
  ///
  /// Throws a [RangeError] if the range is invalid or out of bounds.
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

  /// Converts a line from the collection file into a [Word] object.
  ///
  /// Assumes the line is a comma-separated string with the word value and its index.
  Word getWordByLine(String line) {
    final lineParts = line.split(',');
    return Word(value: lineParts[0], index: int.parse(lineParts[1]));
  }
}
