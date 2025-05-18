# Word Collection Utils

[![Dart CI](https://github.com/thecasualdev17/word_collection_utils/actions/workflows/dart_ci.yml/badge.svg)](https://github.com/thecasualdev17/word_collection_utils/actions/workflows/dart_ci.yml)

Word Collection Utils is a Dart library designed to simplify the processing of CSV files and provide 
utility functions for word collection management. It allows developers to load and parse 
word collections efficiently, making it ideal for applications that require word-based 
operations such as games, educational tools, or data processing. The library supports retrieving 
words by index, selecting random words, and fetching words within a specified range.

## Features

- **Load and Parse CSV Assets**: Handle CSV files with ease.
- **Utility Functions**: Easy-to-use word collection utilities.

## Getting Started

### Prerequisites

- Dart SDK installed.
- Flutter installed (if using this package in a Flutter project).

### Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  word_collection_utils: ^0.1.0
```

Run the following command to install the dependency:

```bash
flutter pub get
```

or

```bash
dart pub get
```

## Usage

### Import the Package

```dart
import 'package:word_collection_utils/word_collection_utils.dart';
```
### Word Collection Utilities

#### Initialize Word Collection

```
final wordCollectionUtils = WordCollectionUtils(collectionPath: 'assets/words.csv');
```

#### Retrieve a Word by Index

```
final word = await wordCollectionUtils.getWord(1);
print('Word: ${word.word}, Index: ${word.index}');
```

#### Retrieve a Random Word

```
final randomWord = await wordCollectionUtils.getRandomWord();
print('Random Word: ${randomWord.word}');
```

#### Retrieve Words by Range

```
final words = await wordCollectionUtils.getWordsByRangeIndex(1, 3);
words.forEach((word) => print('Word: ${word.word}, Index: ${word.index}'));
```

## Sample Usage

### Import the Package

```
import 'package:word_collection_utils/word_collection_utils.dart';
```

### Initialize Word Collection

```
final wordCollectionUtils = WordCollectionUtils(collectionPath: 'assets/words.csv');
```

### Retrieve a Word by Index

```
final word = await wordCollectionUtils.getWord(1);
print('Word: ${word.value}, Index: ${word.index}');
```

### Retrieve a Random Word

```
final randomWord = await wordCollectionUtils.getRandomWord();
print('Random Word: ${randomWord.value}');
```

### Retrieve Words by Range

```
final words = await wordCollectionUtils.getWordsByRangeIndex(1, 3);
words.forEach((word) => print('Word: ${word.value}, Index: ${word.index}'));
```

### Example Program

```
import 'dart:io';
import 'package:word_collection_utils/word_collection_utils.dart';

Future<void> main() async {
  String currentDirectory = Directory.current.path;
  WordCollectionUtils wordCollectionUtils = WordCollectionUtils(
    collectionPath: '$currentDirectory/example/collection.csv',
  );

  print('Random Word: ${(await wordCollectionUtils.getRandomWord()).value}');
  print('Word at Index 0: ${(await wordCollectionUtils.getWord(0)).value}');
  print('Words from Index 0 to 5: ${(await wordCollectionUtils.getWordsByRangeIndex(0, 5)).map((w) => w.value).toList()}');
}
```

## Example

For a complete example, check the `/example` folder in the package repository.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes and push the branch.
4. Open a pull request.

## Additional Information

- To file issues or request features, visit the [GitHub repository](https://github.com/thecasualdev17/word_collection_utils).

## License

This package is licensed under the MIT License. See the `LICENSE` file for more details.