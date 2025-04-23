Word Collection Utils

[![Dart CI](https://github.com/thecasualdev17/word_collection_utils/actions/workflows/dart_ci.yml/badge.svg)](https://github.com/thecasualdev17/word_collection_utils/actions/workflows/dart_ci.#

A Dart package to process JSON or CSV assets, extract their contents, and save them to a database.
This package is designed to simplify asset processing and database management for your Flutter or
Dart projects.

## Features

- Load and parse JSON assets.
- Load and parse CSV assets.
- Easy-to-use utility functions for asset processing.

## Getting Started

### Prerequisites

- Dart SDK installed.
- Flutter installed (if using this package in a Flutter project).

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
```

Run `flutter pub get` or `dart pub get` to install the dependencies.

## Usage

### Import the Package

```dart
import 'package:word_collection_utils/word_collection_utils.dart';
```

### Process a JSON Asset

```dart

final assetProcessor = AssetProcessor();
await
assetProcessor.processJson
('assets/sample.json
'
);
```

### Process a CSV Asset

```dart

final assetProcessor = AssetProcessor();
await
assetProcessor.processCsv
('assets/sample.csv
'
);
```

### Database Operations

The package automatically saves the parsed data to a SQLite database. You can customize the database
operations by modifying the `DBHelper` class.

## Example

For a complete example, check the `/example` folder in the package.

## Additional Information

- For more details on creating Dart packages, visit
  the [Dart guide](https://dart.dev/guides/libraries/create-packages).
- To contribute to this package, file issues, or request features, visit the [GitHub repository](#).

## License

This package is licensed under the MIT License. See the `LICENSE` file for more details.

```yml)