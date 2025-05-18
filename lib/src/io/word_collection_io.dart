import 'dart:convert';
import 'dart:io';

import 'package:word_collection_utils/src/models/file_contents.dart';

class WordCollectionIo {
  WordCollectionIo();

  String? _collectionPath = '';
  String? _metadataPath = '';

  bool _isInitialized = false;
  bool _saveToMemory = false;
  bool _hasHeaders = true;

  FileContents? _collection;
  FileContents? _metadata;

  /// Accessors

  bool get isInitialized => _isInitialized;

  bool get saveToMemory => _saveToMemory;

  bool get hasHeaders => _hasHeaders;

  FileContents? get getCollectionFromMemory => _collection;

  FileContents? get getMetadataFromMemory => _metadata;

  String? get collectionPath => _collectionPath;

  String? get metadataPath => _metadataPath;

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

  Future<FileContents> readFile(String filePath) async {
    late FileContents fileContents;
    if (isInitialized) {
      var stream = File(
        filePath,
      ).openRead().transform(utf8.decoder).transform(LineSplitter());
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
