/// Represents metadata for a single character within a collection,
/// including its value and its start and end indices in a sequence.
class CharacterMetadata {
  /// The character this metadata refers to.
  ///
  /// Must be a single character string.
  String character;

  /// The starting index of the character in the collection.
  ///
  /// Must be greater than or equal to 0.
  int startingIndex;

  /// The ending index of the character in the collection.
  ///
  /// Must be greater than or equal to [startingIndex].
  int endingIndex;

  /// Creates a [CharacterMetadata] instance with the given [character],
  /// [startingIndex], and [endingIndex].
  ///
  /// Throws an [AssertionError] if [character] is not a single character,
  /// if [startingIndex] is negative, or if [endingIndex] is less than [startingIndex].
  CharacterMetadata({
    required this.character,
    required this.startingIndex,
    required this.endingIndex,
  }) : assert(character.length == 1, 'Character length must be 1'),
       assert(
         startingIndex >= 0,
         'Starting index must be greater than or equal to 0',
       ),
       assert(
         endingIndex >= startingIndex,
         'Ending index must be greater than or equal to starting index',
       );
}
