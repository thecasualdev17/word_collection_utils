/// Represents a word in the collection, including its value and position.
class Word {
  /// Creates a [Word] instance with the given [value] and [index].
  const Word({required this.value, required this.index});

  /// The string value of the word.
  final String value;

  /// The position or index of the word in the collection.
  final int index;
}
