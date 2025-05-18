import './character_metadata.dart';

class CollectionMetadata {
  final int totalWordCount;
  final Map<String, CharacterMetadata>? characterMetadata;

  CollectionMetadata({required this.totalWordCount, this.characterMetadata})
    : assert(totalWordCount > 0, 'Total word count must be greater than 0');
}
