import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'file_loader_base.dart';

/// JavaScript interop for fetching file content in web/wasm environments.
///
/// Expects a JavaScript function `fetchFileContent` to be available that returns a Promise of type String.
@JS('fetchFileContent')
external JSPromise fetchFileContent(String path);

/// Implementation of [FileLoaderBase] for web/wasm platforms using JavaScript interop.
class FileLoader extends FileLoaderBase {
  /// Loads the contents of the file at the given [path] as a stream of lines.
  ///
  /// Uses JS interop to fetch the file content from JavaScript,
  /// splits the content into lines, and returns a [Stream] of [String] lines.
  @override
  Future<Stream<String>> getFileStream(String path) async {
    // Await the JS Promise and convert it to a Dart String using js_interop.
    final fileContent = await fetchFileContent(path).toDart;

    // Split the content into lines.
    final lines = LineSplitter.split(fileContent.toString());

    // Return a stream of lines.
    return Stream.fromIterable(lines);
  }
}
