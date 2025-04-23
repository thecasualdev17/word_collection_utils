import 'package:word_collection_utils/src/classes/character_metadata.dart';
import 'package:word_collection_utils/src/classes/collection_metadata.dart';

class WordCollectionUtils {
  final String dataSource;
  final String? mapSource;

  WordCollectionUtils({required this.dataSource, this.mapSource});

  int saveToDb() {
    throw UnimplementedError('saveToDb() has not been implemented.');
  }

  CollectionMetadata getCollectionMetadata() {
    throw UnimplementedError('getSummary() has not been implemented.');
  }

  CollectionMetadata setCollectionMetadata(CollectionMetadata collectionMetadata) {
    throw UnimplementedError('getSummary() has not been implemented.');
  }

  CharacterMetadata getCharacterMetadata(String character) {
    throw UnimplementedError('getCharacterMetadata() has not been implemented.');
  }

  CharacterMetadata setCharacterMetadata(CharacterMetadata characterMetadata) {
    throw UnimplementedError('setCharacterMetadata() has not been implemented.');
  }

  String getWord(int index) {
    throw UnimplementedError('getWord() has not been implemented.');
  }

  String getRandomWord() {
    throw UnimplementedError('getRandomWord() has not been implemented.');
  }

  List<String> getWordsByRangeIndex(int start, int end) {
    throw UnimplementedError('getWordsByRangeIndex() has not been implemented.');
  }
}
