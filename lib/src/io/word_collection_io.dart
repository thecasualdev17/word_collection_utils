import 'package:word_collection_utils/src/file_loader/file_loader.dart';
import 'package:word_collection_utils/src/models/file_contents.dart';

/// Provides utilities for reading and managing word collections and optional metadata
/// from files, with support for in-memory caching and header handling.
class WordCollectionIo {
  /// Creates a new [WordCollectionIo] instance.
  WordCollectionIo();

  String? _collectionPath = '';
  String? _metadataPath = '';

  bool _isInitialized = false;
  bool _saveToMemory = false;
  bool _hasHeaders = true;

  FileContents? _collection;
  FileContents? _metadata;

  /// Indicates whether the IO utility has been initialized with file paths.
  bool get isInitialized => _isInitialized;

  /// Returns whether file contents should be cached in memory after reading.
  bool get saveToMemory => _saveToMemory;

  /// Returns whether the files are expected to have header rows.
  bool get hasHeaders => _hasHeaders;

  /// Returns the word collection loaded in memory, if available.
  FileContents? get getCollectionFromMemory => _collection;

  /// Returns the metadata loaded in memory, if available.
  FileContents? get getMetadataFromMemory => _metadata;

  /// Returns the file path to the word collection.
  String? get collectionPath => _collectionPath;

  /// Returns the file path to the metadata collection.
  String? get metadataPath => _metadataPath;

  final FileLoader _fileLoader = FileLoader();

  /// Initializes the IO utility with the given file paths and options.
  ///
  /// [collectionPath] is required and specifies the path to the word collection file.
  /// [metadataPath] is optional and specifies the path to the metadata file.
  /// [saveToMemory] determines if file contents should be cached in memory.
  /// [hasHeaders] specifies if the files have header rows.
  ///
  /// Returns `true` if initialization is successful.
  bool init({
    required String collectionPath,
    String? metadataPath,
    bool saveToMemory = false,
    bool hasHeaders = true,
  }) {
    _collectionPath = collectionPath;
    if (metadataPath != null && metadataPath.isNotEmpty) {
      _metadataPath = metadataPath;
    }
    if (this.collectionPath != null && this.collectionPath!.isNotEmpty) {
      _isInitialized = true;
    }

    _saveToMemory = saveToMemory;
    _hasHeaders = hasHeaders;

    return isInitialized;
  }

  /// Reads the file at [filePath] and returns its contents as a [FileContents] object.
  ///
  /// Throws an [Exception] if the utility is not initialized.
  Future<FileContents> readFile(String filePath) async {
    late FileContents fileContents;
    if (isInitialized) {
      var stream = await _fileLoader.getFileStream(filePath);
      var list = await stream.toList();
      if (hasHeaders) {
        var headers = list[0];
        list.removeAt(0);
        fileContents = FileContents(lines: list, headers: headers);
      } else {
        fileContents = FileContents(lines: list);
      }
      return fileContents;
    }

    throw Exception('Not Initialized');
  }

  /// Returns the word collection as a [FileContents] object.
  ///
  /// If [saveToMemory] is enabled and the collection is already loaded,
  /// returns the cached version. Otherwise, reads from the file.
  ///
  /// Throws an [Exception] if the utility is not initialized.
  Future<FileContents> getWordCollection() async {
    if (isInitialized) {
      FileContents? collectionFromMemory = getCollectionFromMemory;
      if (saveToMemory && collectionFromMemory != null) {
        return collectionFromMemory;
      } else {
        var result = await readFile(_collectionPath!);
        if (saveToMemory) {
          _collection = result;
        }
        return result;
      }
    } else {
      throw Exception('Not Initialized');
    }
  }

  /// Returns the character metadata as a [FileContents] object.
  ///
  /// If [saveToMemory] is enabled and the metadata is already loaded,
  /// returns the cached version. Otherwise, reads from the file.
  ///
  /// Throws an [Exception] if the utility is not initialized.
  Future<FileContents> getCharacterMetadata() async {
    if (isInitialized) {
      FileContents? metadataFromMemory = getMetadataFromMemory;
      if (saveToMemory && metadataFromMemory != null) {
        assert(_metadata != null);
        return metadataFromMemory;
      } else {
        var result = await readFile(metadataPath!);
        if (saveToMemory) {
          _metadata = result;
        }
        return result;
      }
    } else {
      throw Exception('Not Initialized');
    }
  }
}
