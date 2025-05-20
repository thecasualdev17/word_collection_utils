import './character_metadata.dart';

/// Represents metadata for a word collection, including the total word count
/// and optional metadata for individual characters.
class CollectionMetadata {
  /// The total number of words in the collection.
  ///
  /// Must be greater than 0.
  final int totalWordCount;

  /// Optional metadata for each character in the collection, keyed by character.
  final Map<String, CharacterMetadata>? characterMetadata;

  /// Creates a [CollectionMetadata] instance with the given [totalWordCount]
  /// and optional [characterMetadata].
  ///
  /// Throws an [AssertionError] if [totalWordCount] is not greater than 0.
  CollectionMetadata({required this.totalWordCount, this.characterMetadata})
    : assert(totalWordCount > 0, 'Total word count must be greater than 0');
}
