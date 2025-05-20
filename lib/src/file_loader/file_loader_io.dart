import 'dart:convert';
import 'dart:io';

import 'file_loader_base.dart';

/// Loads file contents using dart:io (native platforms).
class FileLoader extends FileLoaderBase {
  @override
  Future<Stream<String>> getFileStream(String path) async {
    final file = File(path);
    final lines = file
        .openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());
    return lines;
  }
}
