import 'dart:io';

import 'package:word_collection_utils/src/utils/word_collection_utils.dart';

Future<void> main() async {
  String currentDirectory = Directory.current.path;
  WordCollectionUtils wordCollectionUtils = WordCollectionUtils(
    collectionPath: '$currentDirectory/example/collection.csv',
  );

  print('Random Word: ${(await wordCollectionUtils.getRandomWord()).value}');
  print('Word at Index 0: ${(await wordCollectionUtils.getWord(0)).value}');
  print(
    'Words from Index 0 to 5: ${(await wordCollectionUtils.getWordsByRangeIndex(0, 5)).map((w) => w.value).toList()}',
  );
}
